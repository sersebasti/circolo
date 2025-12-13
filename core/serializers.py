from rest_framework import serializers

class AggiungiRigaSerializer(serializers.Serializer):
    prodotto_id = serializers.IntegerField()
    quantita = serializers.IntegerField(min_value=1, default=1)
    note = serializers.CharField(required=False, allow_blank=True, default="")