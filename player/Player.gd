extends CharacterBody3D

signal health_changed

@onready var visuals: Node3D = $visuals
@onready var camera_boom: Node3D = $camera_boom
@onready var player_animator: AnimationPlayer = $"visuals/Delivery Boy/PlayerAnimator"

const WALK_SPEED= 5.0
const SPRINT_SPEED = 8.0

var speed
var max_health: int = 3
var current_health: int = max_health

func _ready() -> void:
	Globals.Player = self
	speed = WALK_SPEED

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(delta: float) -> void:

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var rotation_speed := 20.0
	var weight := 1.0 - pow(0.5, delta * rotation_speed)
	
	if !Globals.game_started:
		return
	else:
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			
			visuals.rotation.y = lerp_angle(visuals.rotation.y, atan2(-direction.x, -direction.z), weight)
			player_animator.play("running")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
			player_animator.play("idle")
		move_and_slide()

func _on_hit_area_area_entered(area: Area3D) -> void:
	if area.name == "HitBox":
		current_health -= 1
		health_changed.emit(current_health)

		if current_health <= 0:
			print("Death")
