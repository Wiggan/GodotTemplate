extends Node
@onready var button_hover = $ButtonHover
@onready var button_click = $ButtonClick
@onready var bgm_1 = $BGM1
@onready var bgm_2 = $BGM2

enum Song {
	MENU,
	GAME,
	SCORE
}

const SONGS = {
	Song.MENU: preload("res://game/BGM/2023-07-31.mp3"),
	Song.GAME: preload("res://game/BGM/2023-08-03.mp3"),
	Song.SCORE: preload("res://game/BGM/2023-07-31.mp3"),
}

@onready var active_player = bgm_1
@onready var inactive_player = bgm_2
var queued_song = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons: Array = get_tree().get_nodes_in_group("Button")
	var sliders: Array = get_tree().get_nodes_in_group("Slider")
	var tab_containers: Array = get_tree().get_nodes_in_group("TabContainer")
	for inst in buttons:
		inst.connect("pressed", on_button_pressed)
		inst.connect("toggled", on_button_toggled)
		inst.connect("mouse_entered", on_focus_entered)
		inst.connect("focus_entered", on_focus_entered)
	
	for inst in sliders:
		inst.connect("drag_started", on_button_pressed)
		inst.connect("mouse_entered", on_focus_entered)
		inst.connect("focus_entered", on_focus_entered)
		
	for inst in tab_containers:
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

func cross_fade(duration=1.0):
	active_player.get_node("AnimationPlayer").play("fade_in", -1, 1.0/duration)
	inactive_player.get_node("AnimationPlayer").play("fade_out", -1, 1.0/duration)

func play_song(song, from_start=false, crossfade_duration=1.0):
	if active_player.stream.resource_path == SONGS[song].resource_path:
		pass
	elif inactive_player.stream.resource_path == SONGS[song].resource_path:
		var temp = active_player
		active_player = inactive_player
		inactive_player = temp
		cross_fade(crossfade_duration)
	else:
		var temp = active_player
		active_player = inactive_player
		inactive_player = temp
		active_player.stream = SONGS[song]
		cross_fade(crossfade_duration)
	
	if from_start:
		active_player.play(0)
	else:
		active_player.play(active_player.get_playback_position())

## Queue 1 song that will be played once currently playing song finshes. If a song was already queued, that one will be replaced.
func queue_song(song):
	queued_song = song

func _on_bgm_finished():
	print("Music finished playing!")
	if queued_song:
		active_player.stream = SONGS[queued_song]
		active_player.play(0)
		queued_song = null
