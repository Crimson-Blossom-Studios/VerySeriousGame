extends Control

@onready var options_menu = $OptionsMenu
@onready var mainMarginContainer = $MainMarginContainer
@onready var resolution_button = $OptionsMenu/OptionsVBoxContainer/ResolutionHBox/ResolutionButton

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_or_cancel"):
		if options_menu.visible:
			_on_back_button_pressed()

func _ready() -> void:
	pass

func _on_start_button_pressed() -> void:
	await TransitionScreen.fade_to_black()
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
	TransitionScreen.fade_to_normal()


func _on_options_button_pressed() -> void:
	mainMarginContainer.hide()
	options_menu.show()


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	await TransitionScreen.fade_to_black()
	get_tree().quit()

func _on_back_button_pressed() -> void:
	options_menu.hide()
	mainMarginContainer.show()


func _on_resolution_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(640, 360))
		1:
			DisplayServer.window_set_size(Vector2i(768, 432))
		2:
			DisplayServer.window_set_size(Vector2i(896, 504))
		3:
			DisplayServer.window_set_size(Vector2i(1024, 576))
		4:
			DisplayServer.window_set_size(Vector2i(1152, 648))
		5:
			DisplayServer.window_set_size(Vector2i(1280, 720))
		6:
			DisplayServer.window_set_size(Vector2i(1920, 1080))


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
