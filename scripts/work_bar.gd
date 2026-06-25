extends ProgressBar

func _ready() -> void:
	max_value = WorkSystem.MAX_WORK
	value = WorkSystem.work
	WorkSystem.work_changed.connect(update_bar)

func update_bar(new_value):
	value = new_value
