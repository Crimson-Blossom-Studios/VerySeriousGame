extends ProgressBar

@export var max_work: float = 100.0
@export var depletion_rate: float = 5.0
@export var gain_per_key: float = 1.0

var work: float
var last_key: Key = KEY_NONE

func _ready() -> void:
	max_value = max_work
	work = max_work
	update_bar()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo:
			if event.keycode != last_key:
				add_work(gain_per_key)
				last_key = event.keycode

func _process(delta: float) -> void:
	remove_work(depletion_rate * delta)

func add_work(amount: float) -> void:
	work = clamp(work + amount, 0.0, max_work)
	update_bar()

func remove_work(amount: float) -> void:
	work = clamp(work - amount, 0.0, max_work)
	update_bar()

func update_bar() -> void:
	value = work
