# res://resources/document_data.gd
class_name DocumentData
extends Resource

@export var id: int
@export var document_name: String = ""
@export var texture: Texture2D
@export var collision_radius: float = 20.0
@export_multiline var conteudo: String = ""
