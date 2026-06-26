extends CanvasLayer

@onready var texture_rect = $ColorRect/TextureRect
@onready var rich_text = $ColorRect/MarginContainer/RichTextLabel
@onready var overlay = $ColorRect/Overlay

func _ready() -> void:
	hide()

func open(documento: Documento) -> void:
	texture_rect.texture = documento.data.texture
	rich_text.text = documento.data.conteudo
	show()

func _on_close_pressed() -> void:
	hide()

func _on_button_pressed() -> void:
	hide()
