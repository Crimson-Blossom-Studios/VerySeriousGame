extends HBoxContainer

@onready var present_scene = $RightPanel/ViewportContainer/RightPanelViewport/PresentScene
@onready var past_scene = $RightPanel/ViewportContainer/RightPanelViewport/PastScene
@onready var future_scene = $RightPanel/ViewportContainer/RightPanelViewport/FutureScene

@onready var time_back_button = $LeftPanel/VBoxContainer/PanelContainer2/teste2/PanelContainer2/tempoContainer/TimeBackButton
@onready var time_forward_button = $LeftPanel/VBoxContainer/PanelContainer2/teste2/PanelContainer2/tempoContainer/TimeForwardButton

@onready var chair_sprite = $LeftPanel/VBoxContainer/PanelContainer2/teste2/PanelContainer2/tempoContainer/Control/AnimatedSprite2D

@onready var conf: EncerrarModal = $RightPanel/ViewportContainer/RightPanelViewport/UI/SolveCaseModal

func _ready() -> void:
	TimelineManager.register(TimelineManager.Timeline.PRESENT, present_scene)
	TimelineManager.register(TimelineManager.Timeline.PAST, past_scene)
	TimelineManager.register(TimelineManager.Timeline.FUTURE, future_scene)
	
	past_scene.visible = false
	past_scene.process_mode = Node.PROCESS_MODE_DISABLED
	future_scene.visible = false
	future_scene.process_mode = Node.PROCESS_MODE_DISABLED
	
	TimelineManager.timeline_changed.connect(update_buttons)

func _on_time_back_button_pressed() -> void:
	chair_sprite.flip_h = false
	chair_sprite.play("default")
	TimelineManager.previous_time()


func _on_time_forward_button_pressed() -> void:
	chair_sprite.flip_h = true
	chair_sprite.play("default")
	TimelineManager.next_time()

func update_buttons(new_time):
	if new_time == TimelineManager.Timeline.PAST:
		time_back_button.disabled = true
		time_forward_button.disabled = false
	elif new_time == TimelineManager.Timeline.FUTURE:
		time_back_button.disabled = false
		time_forward_button.disabled = true
	else:
		time_back_button.disabled = false
		time_forward_button.disabled = false


func _on_solve_case_button_pressed() -> void:
	var confirmed = await conf.prompt()
	if confirmed:
		get_tree().change_scene_to_file("res://scenes/Paper.tscn")
