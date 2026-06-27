extends CanvasLayer

@onready var document_texture_rect = $ColorRect/MarginContainer2/HBoxContainer/TextureRect

func _ready() -> void:
	hide()

func open(documento: Documento) -> void:
	document_texture_rect.texture = documento.data.texture
	show()

func _on_close_pressed() -> void:
	hide()

func _on_texture_button_pressed() -> void:
	hide()
