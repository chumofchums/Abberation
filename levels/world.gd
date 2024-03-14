extends Node3D

signal player_won

@onready var cutscene_camera: Camera3D = $IntroCutscene/CutsceneCamera
@onready var cutscene_player: AnimationPlayer = $IntroCutscene/CutscenePlayer
@onready var gruel_temp_bar: ProgressBar = $Player/PlayerUI/GruelTemperature
@onready var hearts: HBoxContainer = $Player/PlayerUI/HeartContainer
@onready var world: Node3D = $"."
@onready var color_rect: ColorRect = $IntroCutscene/IntroCutsceneColorRect
@onready var game_music: AudioStreamPlayer = $GameMusic
@onready var transition_player: AnimationPlayer = $Transition/AnimationPlayer
@onready var guard_spawn: Node3D = $GuardSpawn
@onready var guard_spawn_2: Node3D = $GuardSpawn2
@onready var guard_spawn_3: Node3D = $GuardSpawn3

@onready var explanation: CanvasLayer = $Explanation
@onready var won_anim: AnimationPlayer = $Player/GameWon/AnimationPlayer

var guard = preload("res://enemy/guard.tscn")
var guard2 = preload("res://enemy/guard_2.tscn")
var guard3 = preload("res://enemy/guard_3.tscn")
var cutscene_complete: bool = false

func _ready() -> void:
	var timer = get_node("Timer")
	timer.timeout.connect(start_cutscene)

func start_cutscene() -> void:
	cutscene_player.play("cutscene")

func start_explanation():
	if Globals.explanation_played == true:
		start_game()
	else:
		explanation.visible = true
		game_music.play()

func start_game():
	if Globals.explanation_played ==true:
		game_music.play()
	Globals.game_started = true
	cutscene_camera.current = false
	gruel_temp_bar.value = 100
	gruel_temp_bar.visible = true
	hearts.visible = true
	color_rect.visible = false
	cutscene_complete = true

func increase_music_speed():
	game_music.pitch_scale = 1.2

func _on_guard_chase_player() -> void:
	increase_music_speed()

func _on_player_player_caught(guard_name: String) -> void:
	reset_player(guard_name)

func reset_player(guard_name: String):
	game_music.pitch_scale = 1
	transition_player.play("fade_out")
	await transition_player.animation_finished

	if guard_name == "Guard":
		var guard_instance = guard.instantiate()
		guard_instance.position = guard_spawn.global_transform.origin
		guard_instance.chase_player.connect(_on_guard_chase_player)
		add_child(guard_instance)
	if guard_name == "Guard2":
		var guard2_instance = guard2.instantiate()
		guard2_instance.position = guard_spawn_2.global_transform.origin
		guard2_instance.chase_player.connect(_on_guard_chase_player)
		add_child(guard2_instance)
	if guard_name == "Guard3":
		var guard3_instance = guard3.instantiate()
		guard3_instance.position = guard_spawn_3.global_transform.origin
		guard3_instance.chase_player.connect(_on_guard_chase_player)
		add_child(guard3_instance)
		
	transition_player.play("fade_in")

func _on_guard_2_chase_player() -> void:
	increase_music_speed()

func _on_end_of_level_body_entered(body: Node3D) -> void:
	player_won.emit()
	gruel_temp_bar.visible = false
	hearts.visible = false
	won_anim.play("game won")
	Globals.game_started = false

func _on_button_pressed() -> void:
	start_game()

func _on_guard_3_chase_player() -> void:
	increase_music_speed()
