from __future__ import annotations

from django.conf import settings
from django.db import models
from django.db.models import Q


class Reparto(models.Model):
    """
    CUCINA, PIZZERIA, BAR.
    auto_pronta=True per BAR: quando invii, le righe vanno subito a PRONTA.
    """
    codice = models.CharField(max_length=20, unique=True)
    nome = models.CharField(max_length=100)
    auto_pronta = models.BooleanField(default=False)
    attivo = models.BooleanField(default=True)

    class Meta:
        db_table = "reparto"
        ordering = ["codice"]

    def __str__(self) -> str:
        return f"{self.codice}"


class Tavolo(models.Model):
    numero = models.PositiveIntegerField(unique=True)
    nome = models.CharField(max_length=100, blank=True)
    attivo = models.BooleanField(default=True)

    class Meta:
        db_table = "tavolo"
        ordering = ["numero"]

    def __str__(self) -> str:
        return self.nome.strip() or f"Tavolo {self.numero}"


class Prodotto(models.Model):
    nome = models.CharField(max_length=200)
    prezzo = models.DecimalField(max_digits=10, decimal_places=2)
    reparto = models.ForeignKey(Reparto, on_delete=models.PROTECT, related_name="prodotti")
    attivo = models.BooleanField(default=True)

    class Meta:
        db_table = "prodotto"
        ordering = ["nome"]

    def __str__(self) -> str:
        return self.nome


class Comanda(models.Model):

    
    coperti = models.PositiveSmallIntegerField(default=1) 
    tavolo = models.OneToOneField(Tavolo,on_delete=models.PROTECT,related_name='commanda_corrente')
    creata_da = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name="comande_create"
    )
    creata_il = models.DateTimeField(auto_now_add=True)
    note = models.TextField(blank=True)
    class Meta:
        db_table = "comanda"
      

    def __str__(self) -> str:
        return f"Comanda #{self.id} - {self.tavolo}"


class RigaComanda(models.Model):
    class Stato(models.TextChoices):
        BOZZA = "BOZZA", "Bozza"
        INVIATA = "INVIATA", "Inviata"
        PRONTA = "PRONTA", "Pronta"
        SERVITA = "SERVITA", "Servita"
        ANNULLATA = "ANNULLATA", "Annullata"

    comanda = models.ForeignKey(Comanda, on_delete=models.CASCADE, related_name="righe")
    prodotto = models.ForeignKey(Prodotto, on_delete=models.PROTECT, related_name="righe_comanda")

    # fotografia del reparto e del prezzo al momento dell'ordine (storico coerente)
    reparto = models.ForeignKey(Reparto, on_delete=models.PROTECT, related_name="righe_comanda")
    quantita = models.PositiveIntegerField(default=1)
    prezzo_unitario = models.DecimalField(max_digits=10, decimal_places=2)
    note = models.TextField(blank=True)

    stato = models.CharField(max_length=10, choices=Stato.choices, default=Stato.BOZZA)

    inviata_il = models.DateTimeField(null=True, blank=True)
    pronta_il = models.DateTimeField(null=True, blank=True)
    servita_il = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "riga_comanda"
        ordering = ["id"]
        indexes = [
            models.Index(fields=["reparto", "stato"], name="idx_riga_rep_stato"),
            models.Index(fields=["comanda"], name="idx_riga_comanda"),
        ]

    def __str__(self) -> str:
        return f"{self.quantita}x {self.prodotto} ({self.reparto.codice}) [{self.stato}]"

# Create your models here.
