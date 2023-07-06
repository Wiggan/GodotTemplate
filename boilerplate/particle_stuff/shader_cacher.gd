extends Node
var show_material_for_one_frame = preload("res://boilerplate/particle_stuff/show_material_for_one_frame.tscn")
# Hack to avoid stuttering when a particle system emits for the first time etc

const DRAW_PASSES_DIR = "res://test/draw_passes/"

func show_all_draw_passes_once():
	var dir = DirAccess.open(DRAW_PASSES_DIR)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				var material_shower = show_material_for_one_frame.instantiate()
				material_shower.mesh = ResourceLoader.load(DRAW_PASSES_DIR + file_name)
				get_tree().get_root().add_child(material_shower)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
