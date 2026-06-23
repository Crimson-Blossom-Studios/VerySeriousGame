extends Node2D

var paper_stack = []
var paper_scene = preload("res://scenes/Paper.tscn")

func _ready() -> void:
	for i in range(2):
		var paper = paper_scene.instantiate()
		add_paper(paper)

func add_paper(paper) -> void:
	add_child(paper)
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
