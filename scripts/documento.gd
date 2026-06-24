extends Area2D

static var dragging_instance = null

var dragging := false
var drag_offset := Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and mouse_in:
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

var mouse_in := false

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
