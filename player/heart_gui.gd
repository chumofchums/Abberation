extends Panel

@onready var empty_img: TextureRect = $EmptyImg
@onready var heart_img: TextureRect = $HeartImg

func hide_heart():
	heart_img.visible = false

func update(whole: bool):
	if whole: 
		heart_img.visible = true
	else:
		heart_img.visible = false
		empty_img.visible = true
