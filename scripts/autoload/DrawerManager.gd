extends Node

var stack: Array[DocumentData] = []
var todos_documentos: Dictionary = {}  # id -> DocumentData

func _ready() -> void:
	_carregar_documentos()

func _carregar_documentos() -> void:
	var dir = DirAccess.open("res://resources/documentos/")
	if dir:
		dir.list_dir_begin()
		var arquivo = dir.get_next()
		while arquivo != "":
			if arquivo.ends_with(".tres"):
				var data = load("res://resources/documentos/" + arquivo)
				if data is DocumentData:
					todos_documentos[data.document_name] = data  # ← indexa por nome
			arquivo = dir.get_next()
		dir.list_dir_end()

func get_por_nome(nome: String) -> DocumentData:
	return todos_documentos.get(nome, null)

func guardar(data: DocumentData) -> void:
	stack.append(data)

func abrir() -> Array[DocumentData]:
	var documentos = stack.duplicate()
	stack.clear()
	return documentos

func esta_vazia() -> bool:
	return stack.is_empty()
