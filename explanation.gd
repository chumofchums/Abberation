extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

func _on_visibility_changed() -> void:
	anim.play("type")

func _on_button_pressed() -> void:
	self.visible = false
	anim.play("onward")
	Globals.explanation_played = true
