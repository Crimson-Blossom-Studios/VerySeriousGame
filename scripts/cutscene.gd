extends Node

@export var video: VideoStreamPlayer
@export var dialogue_box: DialogueBox

var cues: Array = [
	[2.5, [
		{speaker = "", text = "hey look that's an empty square."},
		{speaker = "renato", text = "awesome. this is a second text to test something"}
	]],
	[5.0, [
		{text = "oh look, now there is a lady"}
	]],
]

var cue_index = 0

func _ready() -> void:
	dialogue_box.dialogue_finished.connect(on_dialogue_finished)
	video.play()

func _process(delta: float) -> void:
	if cue_index >= cues.size():
		return
	if dialogue_box.visible:
		return
	
	var cue = cues[cue_index]
	if video.stream_position >= cue[0]:
		cue_index += 1
		video.paused = true
		dialogue_box.show_dialogue(cue[1])

func on_dialogue_finished():
	video.paused = false


func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/presenteScene.tscn")
