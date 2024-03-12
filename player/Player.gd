extends CharacterBody3D

signal health_changed
signal player_caught
signal health_zero

@onready var visuals: Node3D = $visuals
@onready var camera_boom: Node3D = $camera_boom
@onready var player_animator: AnimationPlayer = $"visuals/Delivery Boy/PlayerAnimator"
@onready var spawn_location: Node3D = $"../PlayerSpawn"
@onready var fail_cutscene: AnimationPlayer = $FailCanvasLayer/FailCutscene

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
		player_caught.emit()
		player_animator.play("caught")
		await get_tree().create_timer(.5).timeout
		self.global_transform.origin = spawn_location.global_transform.origin
	
		if current_health <= 0:
			emit_signal("health_zero")
			fail_cutscene.play("fail_anim")

func _on_fail_screen_gruel_cooled() -> void:
	fail_cutscene.play("fail_anim")
