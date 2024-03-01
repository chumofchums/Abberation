extends Panel

@onready var fail_cutscene: AnimationPlayer = $"../FailCutscene"

func _on_gruel_temp_bar_gruel_timeout() -> void:
	fail_cutscene.play("fail_screen")
	await fail_cutscene.animation_finished
	
