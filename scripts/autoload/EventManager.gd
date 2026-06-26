extends Node

# Mapeamento: nome do evento -> { id do documento, timeline onde aparece }
var eventos: Dictionary = {
	# Exemplo:
	# "encontrou_email": {"id": "email_chefe", "timeline": TimelineManager.Timeline.PRESENT},
	# "achou_foto":      {"id": "foto_suspeito", "timeline": TimelineManager.Timeline.PAST},
}

# Cenas registradas por timeline
var cenas: Dictionary = {}  # TimelineManager.Timeline -> Node

func registrar_cena(timeline: TimelineManager.Timeline, cena: Node) -> void:
	cenas[timeline] = cena

func disparar(evento: String) -> void:
	if not eventos.has(evento):
		push_warning("EventManager: evento desconhecido '%s'" % evento)
		return

	var entry = eventos[evento]
	var id: String = entry["id"]
	var timeline: TimelineManager.Timeline = entry["timeline"]

	if not cenas.has(timeline):
		push_warning("EventManager: nenhuma cena registrada para timeline %s" % timeline)
		return

	var data = DrawerManager.get_por_id(id)
	if data == null:
		push_warning("EventManager: documento '%s' não encontrado no GavetaManager" % id)
		return

	cenas[timeline].revelar_documento(data)
