extends CanvasLayer

@onready var gruel_temp_bar: ProgressBar = $GruelTempBar
@onready var retry_button: Button = $"../FailCanvasLayer/FailScreen/VBoxContainer/Retry Button"

func _ready() -> void:
	gruel_temp_bar.visible = false

func grab_focus() -> void:
	retry_button.grab_focus()
