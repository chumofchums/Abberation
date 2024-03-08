extends ProgressBar

signal gruelTimeout

var duration: float = 30.0
var elapsed_time: float = 0.0
var gruelCooled: bool = false

@onready var bar: ProgressBar = $"."

func _ready() -> void:
	bar.value = bar.max_value

func _process(delta: float) -> void:
	if Globals.game_started:
		elapsed_time += delta
		var new_value = bar.max_value - (bar.max_value * elapsed_time/ duration)
		bar.value = max(new_value, 0)
	
	if gruelCooled:
		return
	else:
		if bar.value == 0:
			gruelCooled = true
			gruelTimeout.emit()
			Globals.game_started = false
