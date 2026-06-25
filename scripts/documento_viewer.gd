# res://scripts/document_viewer.gd
extends CanvasLayer

func open(documento: Documento) -> void:
	$ColorRect/TextureRect.texture = documento.data.texture
	show()

func _on_close_pressed() -> void:
	hide()
