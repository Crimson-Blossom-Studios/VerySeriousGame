extends Area2D

var first_time = true

@onready var area: Area2D = $"."
@onready var dialogue_box: DialogueBox = $"../../../UI/DialogueBox"
@onready var modal_computer = $"../../../../../ModalFutureComputer"

const first_dialogue: Array = [
	{"speaker": "Detective Reyes", "text": "Well.. Harry mentioned in his note that he never lost access to the institute's system.."},
	{"speaker": "Detective Reyes", "text": "I should probably try to login in their system."}
]

func _ready() -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("teste")
	print(first_time)
	if not event is InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT or not event.pressed:
		return
	
	if first_time:
		first_time = false
		dialogue_box.show_dialogue(first_dialogue)
		dialogue_box.dialogue_finished.connect(open_computer_modal)
	else:
		open_computer_modal()

func open_computer_modal():
	modal_computer.open()
