extends CanvasLayer

@onready var gruel_temp_bar: ProgressBar = $GruelTempBar
@onready var heart_container: HBoxContainer = $HeartContainer
@export var player: CharacterBody3D

func _ready() -> void:
	gruel_temp_bar.visible = false
	heart_container.set_max_hearts(player.max_health)
	heart_container.update_hearts(player.current_health)
	player.health_changed.connect(heart_container.update_hearts)
