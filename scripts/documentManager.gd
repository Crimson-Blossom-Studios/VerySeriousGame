extends Node

var highest_z := 0

func bring_to_front(document: Node2D):
	highest_z += 1
	document.z_index = highest_z
