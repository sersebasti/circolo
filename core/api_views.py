# core/api_views.py
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .models import Tavolo, Prodotto
from .serializers import AggiungiRigaSerializer, RigaComandaSerializer # type: ignore
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

