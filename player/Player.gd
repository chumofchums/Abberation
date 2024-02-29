extends CharacterBody3D

@onready var visuals: Node3D = $visuals
@onready var camera_boom: Node3D = $camera_boom

const WALK_SPEED= 5.0
const SPRINT_SPEED = 8.0

var speed

func _ready() -> void:
	Globals.Player = self
	speed = WALK_SPEED

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(delta: float) -> void:

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var rotation_speed := 20.0
	var weight := 1.0 - pow(0.5, delta * rotation_speed)

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), weight)
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
