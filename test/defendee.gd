extends CSGCylinder3D


func _on_area_3d_body_entered(_body):
	GameManager.game_over()
