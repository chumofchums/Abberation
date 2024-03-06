extends Node3D

@onready var highlight: MeshInstance3D = $visuals/highlight

func _on_interactable_focused(interactor: Interactor) -> void:
	highlight.visible = true

func _on_interactable_interacted(interactor: Interactor) -> void:
	print("Interact")

func _on_interactable_unfocused(interactor: Interactor) -> void:
		highlight.visible = false
