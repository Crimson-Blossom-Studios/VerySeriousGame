extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.modulate = 0
	color_rect.visible = false

func fade_to_black():
	color_rect.visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
func fade_to_normal():
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	color_rect.visible = false
