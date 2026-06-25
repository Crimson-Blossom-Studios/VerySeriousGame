# res://scripts/documento_viewer.gd
extends CanvasLayer

func _ready() -> void:
	hide()

func open(documento: Documento) -> void:
	$ColorRect/TextureRect.texture = documento.data.texture
	show()

func _on_close_pressed() -> void:
	hide()

func _on_button_pressed() -> void:
	hide()
