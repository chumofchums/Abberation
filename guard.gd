extends CharacterBody3D

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var vision_area: Area3D = $visuals/VisionArea
@onready var visuals: MeshInstance3D = $visuals

@export var patrol_direction: Node3D

const PATROL_SPEED = 2
const CHASE_SPEED = 3

var speed = 2
var acceleration = 10
var direction: Vector3 = Vector3.ZERO
var player_spotted: bool = false

var rotation_speed := 20.0

func _ready() -> void:
	speed = PATROL_SPEED

func _physics_process(delta: float) -> void:
	if !player_spotted:
		velocity = patrol_direction.direction * speed
	else:
		speed = CHASE_SPEED
		nav.target_position = Globals.Player.global_transform.origin
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()

		velocity = velocity.lerp(direction * speed, acceleration * delta)

	var weight := 1.0 - pow(0.5, delta * rotation_speed)
	visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), weight)
	move_and_slide()

func _on_vision_timer_timeout() -> void:
	var overlaps = vision_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				player_spotted = true