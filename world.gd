extends Node3D

@onready var cutscene_camera: Camera3D = $CutsceneCamera
@onready var cutscene_player: AnimationPlayer = $CutscenePlayer
@onready var gruel_temp_bar: ProgressBar = $Player/PlayerUI/GruelTempBar
@onready var world: Node3D = $"."
@onready var color_rect: ColorRect = $ColorRect

var cutscene_complete: bool = false

func _ready() -> void:
	cutscene_player.play("cutscene")

func start_game():
	Globals.game_started = true
	cutscene_camera.current = false
	gruel_temp_bar.visible = true
	color_rect.visible = false
	cutscene_complete = true

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://start_menu.tscn")
