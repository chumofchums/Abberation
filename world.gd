extends Node3D

@onready var cutscene_camera: Camera3D = $CutsceneCamera
@onready var cutscene_player: AnimationPlayer = $CutscenePlayer


func _ready() -> void:
	cutscene_player.play("cutscene")

func start_game():
	Globals.game_started = true
	cutscene_camera.current = false
