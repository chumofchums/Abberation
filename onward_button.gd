extends Button

@onready var audio: AudioStreamPlayer = $"../AudioStreamPlayer"

func grab_button_focus():
	self.grab_focus()

func _on_pressed() -> void:
	audio.play()
