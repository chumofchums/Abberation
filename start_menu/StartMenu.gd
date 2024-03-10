extends CanvasLayer

@onready var scroll_anim: AnimationPlayer = $AnimationPlayer
@onready var anim: AnimationPlayer = $AnimationPlayer2
@onready var menu_music: AudioStreamPlayer2D = $Music2
@onready var start_button: Button = $"Menu/MarginContainer/VBoxContainer/Start Button"
@onready var bg_ambience: AudioStreamPlayer = $"BG Tavern Ambience"
@onready var back_button: Button = $"TextureRect/Back Button"

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	menu_music.stop()
	bg_ambience.stop()
	anim.play("start_game")
	await anim.animation_finished
	#get_tree().change_scene_to_file("res://world.tscn")
	load_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func load_game():
	LoadManager.load_scene("res://levels/world.tscn")
	#LoadManager.load_scene(Globals.world1)

func _on_how_to_button_pressed() -> void:
	scroll_anim.play("close_scroll")
	back_button.grab_focus()

func _on_back_button_pressed() -> void:
	scroll_anim.play("open_scroll")
	start_button.grab_focus()
