# res://scripts/documento.gd
extends Area2D

class_name Documento

static var dragging_instance = null

var dragging := false
var drag_offset := Vector2.ZERO
var mouse_in := false

@export var data: DocumentData

signal document_opened(documento: Documento)

func _ready() -> void:
	print("documento _ready chamado, position: ", global_position)
	print("visivel: ", visible)
	if data:
		$Sprite.texture = data.texture
		var shape = CircleShape2D.new()
		shape.radius = data.collision_radius
		$CollisionShape2D.shape = shape
		
		$NameLabel.text = data.document_name
		var tex = data.texture
		var half_w = tex.get_width() / 2.0
		var half_h = tex.get_height() / 2.0
		
		$NameLabel.custom_minimum_size.x = tex.get_width()
		$NameLabel.position = Vector2(-half_w, half_h + 8)
		$NameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

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
		global_position = get_global_mouse_position() + drag_offset

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
