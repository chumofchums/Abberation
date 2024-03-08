extends Node3D

@onready var cutscene_camera: Camera3D = $IntroCutscene/CutsceneCamera
@onready var cutscene_player: AnimationPlayer = $IntroCutscene/CutscenePlayer
@onready var gruel_temp_bar: ProgressBar = $Player/PlayerUI/GruelTempBar
@onready var hearts: HBoxContainer = $Player/PlayerUI/HeartContainer
@onready var world: Node3D = $"."
@onready var color_rect: ColorRect = $IntroCutscene/IntroCutsceneColorRect
@onready var game_music: AudioStreamPlayer = $GameMusic

var cutscene_complete: bool = false

func _ready() -> void:
	cutscene_player.play("cutscene")

func start_game():
	Globals.game_started = true
	cutscene_camera.current = false
	gruel_temp_bar.visible = true
	hearts.visible = true
	color_rect.visible = false
	cutscene_complete = true
	game_music.play()

func increase_music_speed():
	game_music.pitch_scale = 1.2

func _on_guard_chase_player() -> void:
	increase_music_speed()
