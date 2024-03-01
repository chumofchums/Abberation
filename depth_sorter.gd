extends MeshInstance3D

var distance_threshold = 5.0

func _process(delta):
	# Calculate the distance between the object and the player
	var distance = self.global_transform.origin.distance_to(Globals.Player.global_transform.origin)
	
	# Compare the distance to a threshold
	if distance > distance_threshold:
		# Move the object to the background
		set_to_background()
	else:
		# Move the object to the foreground
		set_to_foreground()

func set_to_foreground():
	# Change the rendering layer to foreground
	set_layer_mask_value(2, true)

func set_to_background():
	# Change the rendering layer to background
	set_layer_mask_value(1, true)
