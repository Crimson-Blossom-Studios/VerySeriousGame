extends Node

enum Timeline {PAST, PRESENT, FUTURE}

var current: Timeline = Timeline.PRESENT

var scenes: Dictionary = {}

signal timeline_changed(new)

func register(timeline, node):
	scenes[timeline] = node

func change_timeline_to(timeline: Timeline):
	if timeline == current:
		return
	
	set_active(scenes[current], false)
	current = timeline
	set_active(scenes[current], true)
	emit_signal("timeline_changed", current)

func next_time():
	var next = current + 1
	if next <= Timeline.FUTURE:
		TransitionTimeScreen.fade_to_black()
		change_timeline_to(next as Timeline)
		TransitionTimeScreen.fade_to_normal()

func previous_time():
	var previous = current - 1
	if previous >= Timeline.PAST:
		TransitionTimeScreen.fade_to_black()
		change_timeline_to(previous as Timeline)
		TransitionTimeScreen.fade_to_normal()

func set_active(node: Node, active):
	node.visible = active
	node.process_mode = (Node.PROCESS_MODE_INHERIT if active else Node.PROCESS_MODE_DISABLED)
