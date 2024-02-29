extends Node3D

@onready var bg_viewport: SubViewport = $base_cam/background_viewport_container/background_viewport
@onready var fg_viewport: SubViewport = $base_cam/foreground_viewport_container/foreground_viewport

@onready var bg_cam: Camera3D = $base_cam/background_viewport_container/background_viewport/background_cam
@onready var fg_cam: Camera3D = $base_cam/foreground_viewport_container/foreground_viewport/foreground_cam


func _ready() -> void:
	resize()

func resize() -> void:
	bg_viewport.size = DisplayServer.window_get_size()
	fg_viewport.size = DisplayServer.window_get_size()
	

func _process(delta: float) -> void:
	bg_cam.global_transform = Globals.Player.camera_boom.global_transform
	fg_cam.global_transform = Globals.Player.camera_boom.global_transform
	
