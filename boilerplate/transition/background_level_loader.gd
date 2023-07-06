extends Control

@onready var progress_bar = $ProgressBar
var scene_to_load = "res://test/test_scene.tscn"
var progress = []

func _ready():
	ResourceLoader.load_threaded_request(scene_to_load)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var status = ResourceLoader.load_threaded_get_status(scene_to_load, progress)
	progress_bar.value = progress[0]
	print("Status: " + str(status) + " Progress: " + str(progress[0]) + " delta: " + str(_delta))
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		print("Finished loading!")
		var packed_scene = ResourceLoader.load_threaded_get(scene_to_load)
		get_tree().change_scene_to_packed(packed_scene)
		queue_free()
		GameManager.unpause()
		Transition.fade_in()
		ShaderCacher.call_deferred("show_all_draw_passes_once")
