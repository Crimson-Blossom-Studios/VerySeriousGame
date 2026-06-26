# res://resources/document_data.gd
class_name DocumentData
extends Resource

@export var id: int
@export var texture: Texture2D
@export var collision_radius: float = 82.0
@export var document_name: String = ""
@export var document_text: String = "" # Rich text Label
