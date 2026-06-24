extends Node2D

@onready var conf: EncerrarModal = $CanvaLayer/EncerrarCasoModal

var paper_stack = []
var paper_scene = preload("res://scenes/Paper.tscn")

func _ready() -> void:
	$CanvaLayer/placeholderFundo.z_index = -1
	for i in range(2):
		var paper = paper_scene.instantiate()
		add_paper(paper)
		
func _unhandled_key_input(event: InputEvent) -> void:	
	var isConfirmed = await conf.prompt(true)
	
	if isConfirmed:
		get_tree().change_scene_to_file("res://scenes/Paper.tscn")

func add_paper(paper) -> void:
	$CanvaLayer.add_child(paper)
	paper_stack.append(paper)
	var viewport_size = get_viewport_rect().size
	paper.position = Vector2(viewport_size.x * 0.5 + randf_range(-60, 60), viewport_size.y * 0.5 + randf_range(-40, 40))
	var count = 0
	for p in paper_stack:
		p.z_index = count
		count += 1

func push_paper_to_top(paper) -> void:
	paper_stack.erase(paper)
	add_paper(paper)
