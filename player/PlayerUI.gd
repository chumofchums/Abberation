extends CanvasLayer

@onready var gruel_temp_bar: ProgressBar = $GruelTempBar
@onready var fail_screen: Panel = $FailScreen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gruel_temp_bar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.game_started:
		gruel_temp_bar.visible = true
