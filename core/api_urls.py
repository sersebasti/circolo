# core/api_urls.py
from django.urls import path
from .api_views import ComandaInviaReparto, ComandaPagaECancella, RepartoCoda, RigaInvia, RigaPronta, RigaServita, RigaUpdate, RighePronteDaServire, TavoloRigheCreate, TavoloCreaComanda

urlpatterns = [
    path("tavoli/<int:tavolo_id>/comanda", TavoloCreaComanda.as_view()),
    # --- CREAZIONE / MODIFICA ---
    path("tavoli/<int:tavolo_id>/righe", TavoloRigheCreate.as_view()),
    path("righe/<int:riga_id>", RigaUpdate.as_view()),
    path("righe/<int:riga_id>/invia", RigaInvia.as_view()),
    path("righe/<int:riga_id>/pronta", RigaPronta.as_view()),
    path("righe/<int:riga_id>/servita", RigaServita.as_view()),
    path("comande/<int:comanda_id>/invia-reparto", ComandaInviaReparto.as_view()),

    # --- LETTURE ---
    path("reparti/<int:reparto_id>/coda", RepartoCoda.as_view()),
    path("righe/pronte", RighePronteDaServire.as_view()),

    # --- PAGAMENTO ---
    path("comande/<int:comanda_id>", ComandaPagaECancella.as_view()),
]
