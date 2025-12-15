# core/api_views.py
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .models import Comanda, Reparto, RigaComanda, Tavolo, Prodotto
from .serializers import AggiungiRigaSerializer, InviaRepartoSerializer, ModificaRigaSerializer, RigaComandaSerializer # type: ignore
from . import services


class TavoloRigheCreate(APIView):
    """
    POST /api/tavoli/<tavolo_id>/righe
    Body: { prodotto_id, quantita, note }
    Risposta: riga creata (JSON)
    """

    def post(self, request, tavolo_id: int):
        ser = AggiungiRigaSerializer(data=request.data)
        ser.is_valid(raise_exception=True)

        tavolo = Tavolo.objects.get(id=tavolo_id)
        prodotto = Prodotto.objects.get(id=ser.validated_data["prodotto_id"])

        # comanda corrente (idempotente)
        comanda = services.get_or_create_comanda_corrente(
            tavolo=tavolo,
            coperti=1,  # per ora; poi possiamo passarli in un endpoint dedicato
            user=request.user if request.user.is_authenticated else None,
        )

        try:
            riga = services.aggiungi_riga(
                comanda=comanda,
                prodotto=prodotto,
                quantita=ser.validated_data["quantita"],
                note=ser.validated_data["note"],
            )
        except ValueError as e:
            return Response({"ok": False, "error": str(e)}, status=status.HTTP_400_BAD_REQUEST)


        # risposta minimale (senza serializer output per ora)
        return Response(
            RigaComandaSerializer(riga).data,
            status=status.HTTP_201_CREATED
        )


class RigaUpdate(APIView):
    def patch(self, request, riga_id):
        ser = ModificaRigaSerializer(data=request.data)
        ser.is_valid(raise_exception=True)

        riga_instance = get_object_or_404(RigaComanda, pk=riga_id)
        riga = services.modifica_riga_bozza(
            riga_id=riga_instance.pk,
            quantita=ser.validated_data.get("quantita"),
            note=ser.validated_data.get("note")
        )
        return Response(
            RigaComandaSerializer(riga).data,
            status=status.HTTP_200_OK
        )
    
class RigaInvia(APIView):
    def post(self, request, riga_id):
        riga_instance = get_object_or_404(RigaComanda, pk=riga_id)
        riga = services.invia_riga(riga=riga_instance)
        return Response(
            RigaComandaSerializer(riga).data,
            status=status.HTTP_200_OK
        )    


class ComandaInviaReparto(APIView):
    def post(self, request, comanda_id):
        ser = InviaRepartoSerializer(data=request.data)
        ser.is_valid(raise_exception=True)

        comanda = get_object_or_404(Comanda, id=comanda_id)
        reparto = get_object_or_404(Reparto, id=ser.validated_data["reparto_id"])
        services.invia_reparto(comanda=comanda, reparto=reparto)
        # Fetch updated rows to return
        righe = comanda.righe.filter(reparto=reparto, stato=services.RigaComanda.Stato.INVIATA)

        return Response(
            RigaComandaSerializer(righe, many=True).data,
            status=status.HTTP_200_OK
        )
    
class RigaPronta(APIView):
    def post(self, request, riga_id):
        riga_instance = get_object_or_404(RigaComanda, pk=riga_id)
        riga = services.segna_pronta(riga=riga_instance)
        return Response(
            RigaComandaSerializer(riga).data,
            status=status.HTTP_200_OK
        )

class RigaServita(APIView):
    def post(self, request, riga_id):
        riga_instance = get_object_or_404(RigaComanda, pk=riga_id)
        riga = services.segna_servita(riga=riga_instance)
        return Response(
            RigaComandaSerializer(riga).data,
            status=status.HTTP_200_OK
        )

class RepartoCoda(APIView):
    def get(self, request, reparto_id):
        reparto = get_object_or_404(Reparto, id=reparto_id)

        righe = services.coda_reparto(reparto=reparto)

        return Response(
            RigaComandaSerializer(righe, many=True).data,
            status=status.HTTP_200_OK
        )

class RighePronteDaServire(APIView):
    def get(self, request):
        righe = services.pronte_da_servire()

        return Response(
            RigaComandaSerializer(righe, many=True).data,
            status=status.HTTP_200_OK
        )
    
class ComandaPagaECancella(APIView):
    def delete(self, request, comanda_id):
        comanda = get_object_or_404(Comanda, id=comanda_id)

        services.paga_e_cancella(comanda=comanda)

        return Response(
            status=status.HTTP_204_NO_CONTENT
        )    
