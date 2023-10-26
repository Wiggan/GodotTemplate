extends Node
@onready var button_hover = $ButtonHover
@onready var button_click = $ButtonClick
@onready var songs = $Songs

enum Song {
	MENU,
	GAME,
	SCORE
}

var SONGS

var audio_streams = {}

var queued_song = null

# Called when the node enters the scene tree for the first time.
func _ready():
	SONGS = {
		Song.MENU: "res://BGM/2023-07-31.mp3",
		Song.GAME: "res://BGM/2023-08-03.mp3",
		Song.SCORE: "res://BGM/2023-07-31.mp3",
	}
	setup_buttons()
	_load_songs()
	
func _load_songs():
	for song in SONGS.keys():
		var audio_stream_player = AudioStreamPlayer.new()
		var stream = load(SONGS[song])
		audio_stream_player.stream = stream
		audio_stream_player.process_mode = PROCESS_MODE_ALWAYS
		audio_stream_player.bus = "BGM"
		audio_stream_player.finished.connect(_on_bgm_finished)
		audio_streams[song] = audio_stream_player
		songs.add_child(audio_stream_player)
		
func setup_buttons():
	var buttons: Array = get_tree().get_nodes_in_group("Button")
	var sliders: Array = get_tree().get_nodes_in_group("Slider")
	var tab_containers: Array = get_tree().get_nodes_in_group("TabContainer")
	for inst in buttons:
		if not inst.is_connected("pressed", on_button_pressed):
			inst.connect("pressed", on_button_pressed)
			inst.connect("toggled", on_button_toggled)
			inst.connect("mouse_entered", on_focus_entered)
			inst.connect("focus_entered", on_focus_entered)
	
	for inst in sliders:
		if not inst.is_connected("drag_started", on_button_pressed):
			inst.connect("drag_started", on_button_pressed)
			inst.connect("mouse_entered", on_focus_entered)
			inst.connect("focus_entered", on_focus_entered)
		
	for inst in tab_containers:
		if not inst.is_connected("tab_changed", on_tab_clicked):
			inst.connect("tab_changed", on_tab_clicked)
			inst.connect("tab_hovered", on_tab_hovered)
		
		
func on_tab_clicked(_tab):
	button_click.play()
	
func on_tab_hovered(_tab):
	button_hover.play()
	
func on_button_pressed()->void:
	button_click.play()
	
func on_button_toggled(_pressed)->void:
	button_click.play()
	
func on_focus_entered()->void:
	button_hover.play()

var music_tween: Tween = null

func get_music_tween():
	if music_tween:
		music_tween.kill()
	music_tween = create_tween()
	return music_tween

func play_song(song, from_start=false, crossfade_duration=1.0):
	var tween = get_music_tween()
	print(audio_streams)
	for audio_stream in audio_streams.keys():
		if song == audio_stream:
			if from_start:
				audio_streams[audio_stream].play(0)
			else:
				audio_streams[audio_stream].play(audio_streams[audio_stream].get_playback_position())
			
			# Only tween its volume if it's not already playing
			if audio_streams[audio_stream].volume_db != 0:
				(tween.parallel().tween_property(audio_streams[audio_stream], "volume_db", 0, crossfade_duration)
				.set_ease(Tween.EASE_OUT)
				.set_trans(Tween.TRANS_QUAD)
				.from(-80))
		else:
			(tween.parallel().tween_property(audio_streams[audio_stream], "volume_db", -80, crossfade_duration)
			.set_ease(Tween.EASE_IN)
			.set_trans(Tween.TRANS_QUAD))
			tween.parallel().tween_callback(audio_streams[audio_stream].stop).set_delay(crossfade_duration)
		

## Queue 1 song that will be played once currently playing song finshes. If a song was already queued, that one will be replaced.
func queue_song(song):
	queued_song = song

func _on_bgm_finished():
	print("Music finished playing!")
	if queued_song:
		play_song(queued_song, true, 0)
		queued_song = null
