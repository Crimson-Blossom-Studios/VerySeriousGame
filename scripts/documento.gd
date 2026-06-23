extends Area2D

var dragging := false
var drag_offset := Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and mouse_in:
				DocumentManager.bring_to_front(self)
				dragging = true
				drag_offset = global_position - get_global_mouse_position()

				# traz o documento para frente
				z_index += 1

			elif !event.pressed:
				dragging = false

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset

var mouse_in := false

func _on_mouse_entered():
	mouse_in = true
	print("True")

func _on_mouse_exited():
	mouse_in = false
