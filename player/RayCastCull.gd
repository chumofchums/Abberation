extends RayCast3D

@onready var cam_trans_anim: AnimationPlayer = $"../CamTransAnimation"
@onready var world: Node3D = $"../../.."


var raycast: RayCast3D
var angled: bool = true
var overhead: bool = false

func _ready() -> void:
	raycast = self

func _process(delta: float) -> void:
	if world.cutscene_complete:
		if raycast.is_colliding():
			set_to_overhead()
		else:
			set_to_angled()

func set_to_overhead():
	if overhead: return
	if angled:
		cam_trans_anim.play("to_overhead")
		await cam_trans_anim.animation_finished
		angled = false
		overhead = true

func set_to_angled():
	if angled: return
	elif overhead:
		cam_trans_anim.play("to_angled")
		await cam_trans_anim.animation_finished
		overhead = false
		angled = true
