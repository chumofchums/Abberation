extends Node3D

signal chest_opened
@onready var sparks: GPUParticles3D = $explosion/sparks
@onready var flash: GPUParticles3D = $explosion/flash
@onready var fire: GPUParticles3D = $explosion/fire
@onready var smoke: GPUParticles3D = $explosion/smoke

@onready var highlight: MeshInstance3D = $visuals/highlight

func _on_interactable_focused(interactor: Interactor) -> void:
	highlight.visible = true

func _on_interactable_interacted(interactor: Interactor) -> void:
	sparks.emitting = true
	flash.emitting = true
	fire.emitting = true
	smoke.emitting = true
	emit_signal("chest_opened")
	await get_tree().create_timer(.5).timeout
	self.queue_free()

func _on_interactable_unfocused(interactor: Interactor) -> void:
		highlight.visible = false
