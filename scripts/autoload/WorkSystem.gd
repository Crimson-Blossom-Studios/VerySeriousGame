extends Node

const MAX_WORK: float = 100.0
const DEPLETION_RATE: float = 1.5
const GAIN_PER_KEY: float = 1.0

var work: float = MAX_WORK
var active = false
var last_key = KEY_NONE

signal work_changed(value)
signal work_activated
signal work_deactivated

func _ready() -> void:
	TimelineManager.timeline_changed.connect(on_timeline_changed)

func _process(delta: float) -> void:
	work = clamp(work - DEPLETION_RATE * delta, 0.0, MAX_WORK)
	emit_signal("work_changed", work)

func _unhandled_input(event: InputEvent) -> void:
	if not active:
		return
	if not event is InputEventKey or not event.is_pressed() or event.is_echo():
		return
	if event.keycode == KEY_ESCAPE:
		deactivate()
		return
	if event.keycode != last_key:
		work = clamp(work + GAIN_PER_KEY, 0.0, MAX_WORK)
		emit_signal("work_changed", work)
		last_key = event.keycode

func activate():
	active = true
	last_key = KEY_NONE
	emit_signal("work_activated")

func deactivate():
	active = false
	last_key = KEY_NONE
	emit_signal("work_deactivated")

func on_timeline_changed(new_timeline):
	if active:
		deactivate()
