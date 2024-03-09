extends PointLight2D

var min_energy: float = 2.3
var max_energy: float = 2.5

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	energy = randf_range(min_energy, max_energy)
	texture_scale = randf_range(19.8, 20.2)
