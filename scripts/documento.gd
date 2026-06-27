# res://scripts/documento.gd
extends Area2D

class_name Documento

static var dragging_instance = null

var dragging := false
var drag_offset := Vector2.ZERO
var mouse_in := false
var bounds := Rect2()

@export var data: DocumentData

signal document_opened(documento: Documento)
signal document_hovered(nome: String)
signal document_unhovered()

func _ready() -> void:
	print("documento _ready chamado, position: ", global_position)
	print("visivel: ", visible)
	if data:
		$Sprite.texture = data.texture
		var shape = CircleShape2D.new()
		shape.radius = data.collision_radius
		$CollisionShape2D.shape = shape

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and mouse_in:
				if event.double_click:
					emit_signal("document_opened", self)
					return
				if dragging_instance == null:
					DocumentManager.bring_to_front(self)
					dragging = true
					dragging_instance = self
					drag_offset = global_position - get_global_mouse_position()
			elif !event.pressed:
				if dragging:
					dragging = false
					dragging_instance = null

func _process(_delta):
	if dragging:
		var target = get_global_mouse_position() + drag_offset
		if bounds != Rect2():
			target.x = clamp(target.x, bounds.position.x, bounds.end.x)
			target.y = clamp(target.y, bounds.position.y, bounds.end.y)
		global_position = target
	$Sprite.flip_h = global_position.x > 210

func _on_mouse_entered():
	mouse_in = true
	emit_signal("document_hovered", data.document_name if data else "")


func _on_mouse_exited():
	mouse_in = false
	emit_signal("document_unhovered")
