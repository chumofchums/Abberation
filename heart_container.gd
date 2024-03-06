extends HBoxContainer

@onready var HeartGuiClass = preload("res://heart_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_max_hearts(max: int):
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)

func empty_heart():
	HeartGuiClass.hide_heart()

func update_hearts(current_health: int):
	var hearts = get_children()
	
	for i in range(current_health):
		hearts[i].update(true)
	
	for i in range(current_health, hearts.size()):
		hearts[i].update(false)
