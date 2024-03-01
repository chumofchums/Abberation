extends CSGBox3D

var layer = 0

func _process(delta: float) -> void:
	if Globals.Player.position.z > position.z: #- self.size.z / 2:
		set_to_background()
	else:
		set_to_foreground()

func set_to_foreground():
	if layer != 2:
		layer = 2
		set_layer_mask_value(1, false)
		set_layer_mask_value(2, true)

func set_to_background():
	if layer != 1:
		layer = 1
		set_layer_mask_value(1, true)
		set_layer_mask_value(2, false)
