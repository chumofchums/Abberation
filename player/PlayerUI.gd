extends CanvasLayer

@onready var gruel_temp_bar: ProgressBar = $GruelTempBar
@onready var fail_screen: Panel = $FailScreen
@onready var retry_button: Button = $"FailScreen/VBoxContainer/Retry Button"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gruel_temp_bar.visible = false

func grab_focus() -> void:
	retry_button.grab_focus()
