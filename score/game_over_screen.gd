extends Control

const GAME_OVER_TEXT = """[center]Your Score: %d[/center]"""

# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/ScoreLabel.text = GAME_OVER_TEXT % GameManager.game_state["Score"]
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/SubmitButton.disabled = false
	$PanelContainer/RetryButton.grab_focus()
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text = Config.nickname
	Transition.fade_in()
	$PanelContainer/MarginContainer/VBoxContainer/ItemList.update_list()
	AudioManager.setup_buttons()

func _on_exit_pressed():
	Transition.fade_and_call(get_tree().quit)

func restart():
	GameManager.state = GameManager.State.Game
	Transition.fade_and_call(Transition.load_level.bind("res://game/game.tscn"))
	#GameManager.unpause()
	Cursor.hide_cursor()
