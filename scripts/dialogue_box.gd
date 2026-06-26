extends CanvasLayer
class_name DialogueBox

signal dialogue_finished

@export var speaker_label: Label
@export var main_text_label: RichTextLabel
@export var continue_label: Label

const type_per_sec: float = 40

var lines: Array = []
var current_line: int
var full_text: String
var is_typing = false

@onready var timer: Timer = Timer.new()

func _ready() -> void:
	timer.wait_time = 1 / type_per_sec
	timer.timeout.connect(on_tick)
	add_child(timer)
	hide()
	continue_label.modulate.a = 0.0

func show_dialogue(lines_array: Array):
	lines = lines_array
	current_line = 0
	show()
	display_line(current_line)
	
func display_line(id):
	var line = lines[id]
	var speaker = line.get("speaker", "")
	if speaker == "":
		speaker_label.hide()
	else:
		speaker_label.text = speaker
		speaker_label.show()
	full_text = line["text"]
	main_text_label.text = ""
	continue_label.modulate.a = 0.0
	is_typing = true
	timer.start()

func on_tick():
	var current_text_lenght = main_text_label.text.length()
	if current_text_lenght < full_text.length():
		main_text_label.text = full_text.substr(0, current_text_lenght + 1)
	else:
		timer.stop()
		is_typing = false
		continue_label.modulate.a = 1.0


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	var clicked = event.is_action_pressed("ui_accept") or \
	(event is InputEventMouseButton and event.is_pressed() and \
	 event.button_index == MOUSE_BUTTON_LEFT)
	if not clicked:
		return
	
	get_viewport().set_input_as_handled()
	
	if is_typing:
		timer.stop()
		is_typing = false
		main_text_label.text = full_text
		continue_label.modulate.a = 1.0
	else:
		current_line += 1
		if current_line < lines.size():
			display_line(current_line)
		else:
			hide()
			dialogue_finished.emit()
