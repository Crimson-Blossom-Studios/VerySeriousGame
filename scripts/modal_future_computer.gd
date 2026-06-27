extends CanvasLayer

const CORRECT_PASSWORD: String = "051174"

var typed_password: String
var unlocked: bool = false

@onready var PasswordPanel = $PasswordPanel
@onready var ButtonsPanel = $ButtonsPanel
@onready var LabelError = $PasswordPanel/LabelError
@onready var digits: Array = [
	$PasswordPanel/HBoxDigits/Digit1,
	$PasswordPanel/HBoxDigits/Digit2,
	$PasswordPanel/HBoxDigits/Digit3,
	$PasswordPanel/HBoxDigits/Digit4,
	$PasswordPanel/HBoxDigits/Digit5,
	$PasswordPanel/HBoxDigits/Digit6
]

func _ready() -> void:
	hide()

func open():
	show()
	if unlocked:
		PasswordPanel.visible = false
		ButtonsPanel.visible = true
	else:
		PasswordPanel.visible = true
		ButtonsPanel.visible = false
		LabelError.visible = false
		typed_password = ""
		update_digits()

func _unhandled_input(event: InputEvent) -> void:
	if not visible or unlocked:
		return
	if not event is InputEventKey or not event.is_pressed() or event.is_echo():
		return
	
	if event.keycode == KEY_BACKSPACE:
		if typed_password.length() > 0:
			typed_password = typed_password.substr(0, typed_password.length() - 1)
			LabelError.visible = false
			update_digits()
		return
	var digit = key_to_digit(event.keycode)
	if digit == "" or typed_password.length() >= 6:
		return
	
	LabelError.visible = false
	typed_password += digit
	update_digits()
	
	if typed_password.length() == 6:
		verify_password()
	
func key_to_digit(keycode):
	if keycode >= KEY_0 and keycode <= KEY_9:
		return str(keycode - KEY_0)
	if keycode >= KEY_KP_0 and keycode <= KEY_KP_9:
		return str(keycode - KEY_KP_0)
	return ""

func verify_password():
	if typed_password == CORRECT_PASSWORD:
		unlocked = true
		PasswordPanel.visible = false
		ButtonsPanel.visible = true
	else:
		LabelError.visible = true
		typed_password = ""
		update_digits()

func update_digits():
	for i in range(6):
		if i < typed_password.length():
			digits[i].text = "•"
		elif i == typed_password.length():
			digits[i].text = "_"
		else:
			digits[i].text = " "
	
func _on_back_button_pressed() -> void:
	hide()
