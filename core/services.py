# core/services.py
from __future__ import annotations

from django.db import transaction, IntegrityError
from django.utils import timezone

from .models import Tavolo, Comanda, RigaComanda, Reparto, Prodotto

# -------------------------
# COMANDA
# -------------------------

@transaction.atomic
def get_or_create_comanda_corrente(*, tavolo: Tavolo, coperti: int, user) -> Comanda:
    """
    Ritorna la comanda corrente del tavolo (OneToOne).
    Se non esiste, la crea. Idempotente.
    """
    if coperti < 1:
        coperti = 1

    try:
        return tavolo.comanda_corrente  # related_name
    except Comanda.DoesNotExist:
        pass

    try:
        return Comanda.objects.create(
            tavolo=tavolo,
            coperti=coperti,
            creata_da=user,
        )
    except IntegrityError:
        # race condition rara: due create contemporanee
        return tavolo.comanda_corrente


@transaction.atomic
def set_coperti(*, comanda: Comanda, coperti: int) -> Comanda:
    """
    Coperti sempre modificabili finché la comanda esiste.
    """
    if coperti < 1:
        coperti = 1
    comanda.coperti = coperti
    comanda.save(update_fields=["coperti"])
    return comanda


# -------------------------
# RIGHE - CREAZIONE/BOZZA
# -------------------------

@transaction.atomic
def aggiungi_riga(
    *,
    comanda: Comanda,
    prodotto: Prodotto,
    quantita: int = 1,
    note: str = "",
) -> RigaComanda:
    """
    Crea una riga:
      - BAR (reparto.auto_pronta=True): nasce PRONTA (+pronta_il)
      - altri reparti: nasce BOZZA
    """
    if quantita < 1:
        quantita = 1

    now = timezone.now()
    reparto = prodotto.reparto

    stato = RigaComanda.Stato.PRONTA if reparto.auto_pronta else RigaComanda.Stato.BOZZA

    riga = RigaComanda.objects.create(
        comanda=comanda,
        prodotto=prodotto,
        quantita=quantita,
        note=note,
        reparto=reparto,
        prezzo_unitario=prodotto.prezzo,  # snapshot
        stato=stato,
        pronta_il=now if stato == RigaComanda.Stato.PRONTA else None,
    )
    return riga


@transaction.atomic
def modifica_riga_bozza(*, riga: RigaComanda, quantita: int | None = None, note: str | None = None) -> RigaComanda:
    """
    Modifiche consentite SOLO se BOZZA.
    """
    if riga.stato != RigaComanda.Stato.BOZZA:
        raise ValueError("Puoi modificare solo righe in stato BOZZA.")

    update_fields = []

    if quantita is not None:
        if quantita < 1:
            raise ValueError("quantita deve essere >= 1")
        riga.quantita = quantita
        update_fields.append("quantita")

    if note is not None:
        riga.note = note
        update_fields.append("note")

    if update_fields:
        riga.save(update_fields=update_fields)

    return riga


@transaction.atomic
def elimina_riga_bozza(*, riga: RigaComanda) -> None:
    """
    Elimina SOLO se BOZZA (idempotente se la riga non esiste più lo gestisci a livello view).
    """
    if riga.stato != RigaComanda.Stato.BOZZA:
        raise ValueError("Puoi eliminare solo righe in stato BOZZA.")
    riga.delete()


# -------------------------
# INVIO IN PRODUZIONE (solo reparti NON auto_pronta)
# -------------------------

@transaction.atomic
def invia_riga(*, riga: RigaComanda) -> RigaComanda:
    """
    BOZZA -> INVIATA (solo se reparto.auto_pronta=False).
    Idempotente: se non è BOZZA, non cambia nulla.
    """
    if riga.reparto.auto_pronta:
        # BAR: non si invia
        return riga

    if riga.stato != RigaComanda.Stato.BOZZA:
        return riga

    now = timezone.now()
    riga.stato = RigaComanda.Stato.INVIATA
    riga.inviata_il = now
    riga.save(update_fields=["stato", "inviata_il"])
    return riga


@transaction.atomic
def invia_reparto(*, comanda: Comanda, reparto: Reparto) -> int:
    """
    Invia tutte le righe BOZZA di quel reparto.
    Solo se reparto.auto_pronta=False (cucina/pizzeria).
    Idempotente.
    Ritorna quante righe sono state inviate.
    """
    if reparto.auto_pronta:
        return 0

    now = timezone.now()
    qs = comanda.righe.filter(reparto=reparto, stato=RigaComanda.Stato.BOZZA)

    # update "bulk" (veloce) e idempotente
    updated = qs.update(stato=RigaComanda.Stato.INVIATA, inviata_il=now)
    return updated


# -------------------------
# PRODUZIONE / SERVIZIO
# -------------------------

@transaction.atomic
def segna_pronta(*, riga: RigaComanda) -> RigaComanda:
    """
    INVIATA -> PRONTA (idempotente)
    """
    if riga.stato == RigaComanda.Stato.PRONTA:
        return riga
    if riga.stato != RigaComanda.Stato.INVIATA:
        raise ValueError("Puoi segnare PRONTA solo una riga in stato INVIATA.")

    now = timezone.now()
    riga.stato = RigaComanda.Stato.PRONTA
    riga.pronta_il = now
    riga.save(update_fields=["stato", "pronta_il"])
    return riga


@transaction.atomic
def segna_servita(*, riga: RigaComanda) -> RigaComanda:
    """
    PRONTA -> SERVITA (idempotente)
    """
    if riga.stato == RigaComanda.Stato.SERVITA:
        return riga
    if riga.stato != RigaComanda.Stato.PRONTA:
        raise ValueError("Puoi segnare SERVITA solo una riga in stato PRONTA.")

    now = timezone.now()
    riga.stato = RigaComanda.Stato.SERVITA
    riga.servita_il = now
    riga.save(update_fields=["stato", "servita_il"])
    return riga


# -------------------------
# LETTURE (CODE)
# -------------------------

def coda_reparto(*, reparto: Reparto):
    """
    Righe INVIATE ordinate per inviata_il (ordine di invio).
    """
    return (
        RigaComanda.objects
        .filter(reparto=reparto, stato=RigaComanda.Stato.INVIATA)
        .order_by("inviata_il", "id")
    )


def pronte_da_servire():
    """
    Righe PRONTE non servite (in pratica PRONTA) ordinate per pronta_il.
    """
    return (
        RigaComanda.objects
        .filter(stato=RigaComanda.Stato.PRONTA)
        .order_by("pronta_il", "id")
    )


# -------------------------
# PAGAMENTO (DELETE, zero tracce)
# -------------------------

@transaction.atomic
def paga_e_cancella(*, comanda: Comanda) -> None:
    comanda.delete()
