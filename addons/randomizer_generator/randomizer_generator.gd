@tool
extends EditorPlugin

const COMMAND_NAME = "Generate Randomizer"
var dialog

func _enter_tree():
	add_tool_menu_item(COMMAND_NAME, show_dialog)
	dialog = FileDialog.new()
	dialog.set_filters(PackedStringArray(["*.wav"]))
	dialog.set_file_mode(FileDialog.FILE_MODE_OPEN_FILES)
	dialog.connect("files_selected", files_selected)

func _input(event):
	if Input.is_key_pressed(KEY_R) and Input.is_key_pressed(KEY_CTRL) and Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_ALT):
		show_dialog()

func show_dialog():
	add_child(dialog)
	dialog.popup_centered(Vector2(300, 400))

func files_selected(paths):
	var randomizer = FileAccess.open(paths[0].get_basename()+".tres", FileAccess.WRITE)
	randomizer.store_line('[gd_resource type="AudioStreamRandomizer"]')

	for path in paths:
		randomizer.store_line('[ext_resource type="AudioStream" path="' + path + '" id="' + path.sha1_text() +'"]')
	
	randomizer.store_line('[resource]')
	randomizer.store_line('streams_count = ' + str(len(paths)))
	for i in range(len(paths)):
		randomizer.store_line('stream_' + str(i) + '/stream = ExtResource("' + paths[i].sha1_text() + '")')	
		randomizer.store_line('stream_' + str(i) + '/weight = 1.0')
	
	randomizer.close()
	get_editor_interface().get_resource_filesystem().scan()
	print("Done!")
	
func _exit_tree():
	remove_tool_menu_item(COMMAND_NAME)
	if dialog:
		dialog.queue_free()
