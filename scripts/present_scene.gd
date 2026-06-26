extends Node2D

var documento_stack = []
var documento_scene = preload("res://scenes/documento.tscn")

var documentos_iniciais: Array[String] = ["doc_teste"]

@onready var drawer = $Drawer
@onready var viewer = get_tree().root.find_child("DocumentoViewer", true, false)

func _ready() -> void:
	EventManager.registrar_cena(TimelineManager.Timeline.PRESENT, self)
	drawer.gaveta_aberta.connect(_on_gaveta_aberta)
	print("drawer conectado") 
	for nome in documentos_iniciais:
		var data = DrawerManager.get_por_nome(nome)
		print(data)
		if data:
			spawn_document(data)

func revelar_documento(data: DocumentData) -> void:
	spawn_document(data)

func spawn_document(data: DocumentData) -> void:
	var documento = documento_scene.instantiate()
	documento.data = data
	documento.document_opened.connect(_on_document_opened)
	documento.document_hovered.connect(_on_document_hovered)
	documento.document_unhovered.connect(_on_document_unhovered)
	add_documento(documento)
	var margin = data.collision_radius
	documento.bounds = Rect2(
		Vector2(margin, margin),
		Vector2(420 - margin * 2, 360 - margin * 2)
	)

func add_documento(documento) -> void:
	add_child(documento)
	documento_stack.append(documento)
	documento.position = Vector2(
		210 + randf_range(-60, 60),
		180 + randf_range(-40, 40)
	)
	var count = 0
	for p in documento_stack:
		p.z_index = count
		count += 1
		
func push_documento_to_top(documento) -> void:
	documento_stack.erase(documento)
	add_documento(documento)
	
func _on_gaveta_aberta() -> void:
	for data in DrawerManager.abrir():
		spawn_document(data)
		
func _on_document_opened(documento: Documento) -> void:
	viewer.open(documento)
	
func _on_document_hovered(nome: String) -> void:
	%Label.text = nome
	
func _on_document_unhovered() -> void:
	%Label.text = "Double-click any document to inspect"
