extends RayCast3D

var raycast: RayCast3D

func _ready() -> void:
	raycast = self

func _process(delta: float) -> void:
	if raycast.is_colliding():
		set_to_background()
	else:
		set_to_foreground()

func set_to_background():
	pass

func set_to_foreground():
	pass
