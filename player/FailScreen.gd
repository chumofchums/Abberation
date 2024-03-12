extends Panel
signal gruel_cooled

@onready var fail_cutscene: AnimationPlayer = $"../FailCutscene"

#func _on_gruel_temp_bar_gruel_timeout() -> void:
	#emit_signal("gruel_cooled")
	#fail_cutscene.play("fail_anim")
	#await fail_cutscene.animation_finished

func _on_gruel_temperature_gruel_timeout() -> void:
	emit_signal("gruel_cooled")
	fail_cutscene.play("fail_anim")
	await fail_cutscene.animation_finished
