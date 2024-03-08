extends Node3D

@export var group_name: String
var positions: Array
var temp_positions: Array
var current_position: Marker3D

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	positions = get_tree().get_nodes_in_group(group_name)
	get_positions()
	get_next_position()

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if global_position.distance_to(current_position.position) < 1:
		get_next_position()

func get_positions() -> void:
	temp_positions = positions.duplicate()

func get_next_position() -> void:
	if temp_positions.is_empty():
		get_positions()
	current_position = temp_positions.pop_front()
	direction = to_local(current_position.position).normalized()
