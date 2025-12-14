from rest_framework import serializers
from .models import RigaComanda

class AggiungiRigaSerializer(serializers.Serializer):
    prodotto_id = serializers.IntegerField()
    quantita = serializers.IntegerField(min_value=1, default=1)
    note = serializers.CharField(required=False, allow_blank=True, default="")

class RigaComandaSerializer(serializers.ModelSerializer):
    class Meta:
        model = RigaComanda
        fields = [
            "id",
            "comanda_id",
            "prodotto_id",
            "reparto_id",
            "quantita",
            "note",
            "stato",
            "inviata_il",
            "pronta_il",
            "servita_il",
        ]

class ModificaRigaSerializer(serializers.Serializer):
    quantita = serializers.IntegerField(min_value=1, required=False)
    note = serializers.CharField(required=False, allow_blank=True)


class InviaRepartoSerializer(serializers.Serializer):
    reparto_id = serializers.IntegerField()
