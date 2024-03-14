extends Node

@onready var button: Button = $CanvasLayer/Button

func grab_focus():
	button.grab_focus()

func _on_button_pressed() -> void:
	Globals.explanation_played = false
	LoadManager.load_scene("res://start_menu/start.tscn")
