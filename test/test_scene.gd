extends NavigationRegion3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.game_state = {
		"Time": 0
	}


func _on_timer_timeout():
	GameManager.game_state["Time"] += 1
