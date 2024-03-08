extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = $Panel/ProgressBar

func update_progress_bar(new_value: float) -> void:
	progress_bar.set_value_no_signal(new_value * 100)

func start_outro_animation() -> void:
	await Signal(animation_player, "animation_finished")
	animation_player.play("end_load")
	await Signal(animation_player, "animation_finished")
	self.queue_free()
