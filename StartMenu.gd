extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var menu_music: AudioStreamPlayer2D = $Music2
@onready var start_button: Button = $"Menu/MarginContainer/VBoxContainer/Start Button"
@onready var bg_ambience: AudioStreamPlayer = $"BG Tavern Ambience"

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
	LoadManager.load_scene("res://world.tscn")
	#LoadManager.load_scene(Globals.world1)
