extends CanvasLayer

@onready var gruel_temp_bar: ProgressBar = $GruelTempBar
@onready var fail_screen: Panel = $FailScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gruel_temp_bar.visible = false
	#fail_screen.visible = false


