extends Node

signal progress_changed(progress)
signal load_done

var load_screen_path: String = "res://loading_screen/loading_screen.tscn"
var load_screen = load(load_screen_path)
var loaded_resource: PackedScene
var _scene_path: String
var progress: Array = []

var use_sub_threads: bool = true

func load_scene(scene_path: String) -> void:
	_scene_path = scene_path
	
	var new_loading_screen = load_screen.instantiate()
	get_tree().get_root().add_child(new_loading_screen)
	
	self.progress_changed.connect(new_loading_screen.update_progress_bar)
	self.load_done.connect(new_loading_screen.start_outro_animation)
	
	await Signal(new_loading_screen, "loading_screen_has_full_coverage")
	
	start_load()

#if issues with loading try disabling "use_sub_threads"
func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(_scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(_scene_path, progress)
	match load_status:
		0, 2: #? Thread_load_invalid_resource, Thread load failed
			set_process(false)
			return
		1: #? Thread_load_in_progress
			emit_signal("progress_changed", progress[0])
		3: #? Thread_Load_loaded
			loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			emit_signal("progress_changed", 1.0)
			emit_signal("load_done")
			get_tree().change_scene_to_packed(loaded_resource)
	
	
	
	
