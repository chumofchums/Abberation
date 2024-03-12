extends ProgressBar

signal gruelTimeout

var duration: float = 30.0
var chest_opened_bonus = 10
var elapsed_time: float = 0.0
var gruelCooled: bool = false
var health_depleted = false

@onready var bar: ProgressBar = $"."
@onready var fail_canvas_layer: CanvasLayer = $"../../FailCanvasLayer"

func _ready() -> void:
	bar.value = bar.max_value

func _process(delta: float) -> void:
	if Globals.game_started:
		elapsed_time += delta
		var new_value = bar.max_value - (bar.max_value * elapsed_time/ duration)
		bar.value = max(new_value, 0)
		update_bar_color()
	
	if gruelCooled:
		return
	else:
		if bar.value == 0:
			gruelCooled = true
			gruelTimeout.emit()
			Globals.game_started = false
			fail_canvas_layer.grab_focus()
		elif health_depleted:
			Globals.game_started = false

func update_bar_color():
	var value_percent = bar.value / bar.max_value
	var color = Color(value_percent, 0.0, 1.0 - value_percent, 1.0)
	bar.modulate = color

func _on_player_health_zero() -> void:
	health_depleted = true

func _on_chest_chest_opened() -> void:
	duration += chest_opened_bonus
