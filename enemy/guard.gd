extends CharacterBody3D

signal chase_player

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var vision_area: Area3D = $visuals/VisionArea
@onready var visuals: MeshInstance3D = $visuals
@onready var anim: AnimationPlayer = $AnimationPlayer
@export var patrol_direction: Node3D
@onready var model_anim: AnimationPlayer = $visuals/Guard/AnimationPlayer


const PATROL_SPEED = 2
const CHASE_SPEED = 3

var speed = 2
var acceleration = 10
var direction: Vector3 = Vector3.ZERO
var player_spotted: bool = false
var rotation_speed: float = 20.0

func _ready() -> void:
	speed = PATROL_SPEED
	

func _physics_process(delta: float) -> void:
	var weight := 1.0 - pow(0.5, delta * rotation_speed)
	if !player_spotted:
		speed = PATROL_SPEED
		velocity = patrol_direction.direction * speed
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-patrol_direction.direction.x, -patrol_direction.direction.z), weight)
	else:
		speed = CHASE_SPEED
		nav.target_position = Globals.Player.global_transform.origin
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), weight)
	model_anim.play("patrol")
	move_and_slide()

func _on_vision_timer_timeout() -> void:
	var overlaps = vision_area.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if player_spotted:
				return
			else:
				if overlap.name == "Player":
					_on_player_spotted()

func _on_player_spotted():
	player_spotted = true
	chase_player.emit()
	anim.play("player_spotted")

func _on_hit_box_area_entered(area: Area3D) -> void:
	if area.name == "HurtBox":
		player_spotted = false
		queue_free()
