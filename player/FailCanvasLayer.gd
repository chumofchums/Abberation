extends CanvasLayer

@onready var retry_button: Button = $"FailScreen/VBoxContainer/Retry Button"

func grab_focus() -> void:
	retry_button.grab_focus()

func _on_retry_button_pressed() -> void:
	LoadManager.load_scene("res://levels/world.tscn")
	#get_tree().change_scene_to_file("res://levels/world.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://start_menu/start.tscn")
