# res://resources/document_data.gd
class_name DocumentData
extends Resource

@export var texture: Texture2D
@export var collision_radius: float = 82.0

# Campos opcionais para lógica de jogo
@export var document_name: String = ""
