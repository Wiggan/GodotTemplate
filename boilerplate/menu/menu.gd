extends VBoxContainer
@onready var options = $"../SubMenus/Options"
@onready var credits = $"../SubMenus/Credits"
@onready var how_to_play = $"../SubMenus/HowToPlay"
@onready var resume = $Resume
@onready var start = $Start
@onready var high_score = $"../SubMenus/HighScore"

@onready var sub_menu_animator = $"../SubMenuAnimator"
@onready var sub_menus = $"../SubMenus"

func _ready():
	visibility_changed.connect(_on_visibility_changed)

func _on_show():
	resume.grab_focus()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if sub_menus.visible:
			sub_menu_animator.play("hide_submenu")
			
			# Consume this event so that menu does not close on escape
			get_viewport().set_input_as_handled()


func _on_resume_pressed():
	if GameManager.state == GameManager.State.Game:
		create_tween().tween_callback(GameManager.unpause).set_delay(0.3)
	elif GameManager.has_saved_game():
		GameManager.restart(false)

func _on_start_pressed():
	GameManager.restart(true)

func _on_how_to_play_pressed():
	options.visible = false
	credits.visible = false
	how_to_play.visible = true
	high_score.visible = false
	sub_menu_animator.play("show_submenu")

func _on_options_pressed():
	options.visible = true
	credits.visible = false
	how_to_play.visible = false
	high_score.visible = false
	sub_menu_animator.play("show_submenu")

func _on_credits_pressed():
	options.visible = false
	credits.visible = true
	how_to_play.visible = false
	high_score.visible = false
	sub_menu_animator.play("show_submenu")

func _on_highscore_pressed():
	options.visible = false
	credits.visible = false
	how_to_play.visible = false
	high_score.visible = true
	$"../SubMenus/HighScore/HighScore/VBoxContainer/HighScore".update_list()
	sub_menu_animator.play("show_submenu")

func _on_exit_pressed():
	Transition.fade_and_call(get_tree().quit)


func _on_back_button_pressed():
	sub_menu_animator.play("hide_submenu")

func _on_visibility_changed():
	if $"..".is_visible_in_tree():
		if GameManager.state == GameManager.State.Game or GameManager.has_saved_game():
			resume.disabled = false
			resume.grab_focus()
		else:
			resume.disabled = true
			start.grab_focus()
			
		
