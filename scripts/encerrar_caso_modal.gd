class_name EncerrarModal extends Control

signal confirmed(is_confirmed:bool)


@onready var tituloLabel: Label = %titulo
@onready var descricaoLabel: Label = %descricao
@onready var confirmarButton: Button = %confirmarButton
@onready var cancelarButton: Button = %cancelarButton

var isOpen: bool = false

var _should_unpause: bool = false

func _ready() -> void:
		set_process_unhandled_key_input(false)
		if confirmarButton:
			confirmarButton.pressed.connect(_on_confirmarButton_pressed)
		if cancelarButton:
			cancelarButton.pressed.connect(_on_cancelarButton_pressed)
		hide()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		cancel()


func prompt(pause: bool = false)-> bool:
	_should_unpause = (get_tree().paused == false) and pause
	if pause:
		get_tree().paused = true
	show()
	isOpen = true
	set_process_unhandled_key_input(true)
	
	return await confirmed

func customize(titulo: String, corpo: String, confirmarText: String = "Sim", cancelarText: String = "Não") -> EncerrarModal:
	tituloLabel.text = titulo
	descricaoLabel.text = corpo
	confirmarButton.text = confirmarText
	cancelarButton.text = cancelarText
	return self

		
func close(isConfirmed: bool = false) -> void:
	if isConfirmed:
		confirm()
	else:
		cancel()

func confirm() -> void:
	_close_modal(true)
	
func cancel() -> void:
	_close_modal(false)

func _close_modal(isConfirmed: bool) -> void:
	set_process_unhandled_key_input(false)
	confirmed.emit(isConfirmed)
	set_deferred("isOpen", false)
	hide()
	if _should_unpause:
		get_tree().paused = false
	
func _on_confirmarButton_pressed() -> void:
	confirm()
	
func _on_cancelarButton_pressed() -> void:
	cancel()
