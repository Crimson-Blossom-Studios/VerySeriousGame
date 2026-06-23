extends Node2D

var paper_stack = []
var paper_scene = preload("res://scenes/Paper.tscn")

func _ready() -> void:
	for i in range(2):
		var paper = paper_scene.instantiate()
		add_paper(paper)

func add_paper(paper) -> void:
	paper_stack.append(paper)

	var count = 0
	for p in paper_stack:
		p.z_index = count
		count += 1

func push_paper_to_top(paper) -> void:
	paper_stack.erase(paper)
	add_paper(paper)
