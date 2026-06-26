extends Area2D

signal gaveta_aberta

var mouse_in := false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.double_click and mouse_in:
				print("duplo clique na gaveta | vazia: ", DrawerManager.esta_vazia())
				if not DrawerManager.esta_vazia():
					emit_signal("gaveta_aberta")

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
