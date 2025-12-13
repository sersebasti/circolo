from django.contrib import admin
from .models import Reparto, Tavolo, Prodotto, Comanda, RigaComanda


@admin.register(Reparto)
class RepartoAdmin(admin.ModelAdmin):
    list_display = ("codice", "nome", "auto_pronta", "attivo")
    list_filter = ("auto_pronta", "attivo")
    search_fields = ("codice", "nome")


@admin.register(Tavolo)
class TavoloAdmin(admin.ModelAdmin):
    list_display = ("numero", "nome", "attivo")
    list_filter = ("attivo",)
    search_fields = ("numero", "nome")


@admin.register(Prodotto)
class ProdottoAdmin(admin.ModelAdmin):
    list_display = ("nome", "prezzo", "reparto", "attivo")
    list_filter = ("reparto", "attivo")
    search_fields = ("nome",)


class RigaInline(admin.TabularInline):
    model = RigaComanda
    extra = 0


@admin.register(Comanda)
class ComandaAdmin(admin.ModelAdmin):
    list_display = ("id", "tavolo", "coperti", "creata_da", "creata_il")
    list_filter = ("tavolo",)
    search_fields = ("id", "tavolo__numero", "tavolo__nome")
    inlines = [RigaInline]


@admin.register(RigaComanda)
class RigaComandaAdmin(admin.ModelAdmin):
    list_display = ("id", "comanda", "prodotto", "reparto", "quantita", "stato", "inviata_il", "pronta_il", "servita_il")
    list_filter = ("reparto", "stato")
    search_fields = ("comanda__id", "prodotto__nome")

