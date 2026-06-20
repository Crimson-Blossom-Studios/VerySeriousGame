extends CheckButton

signal activateWork()

func _on_toggled(button_pressed: bool) -> void:
	activateWork.emit(button_pressed)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
