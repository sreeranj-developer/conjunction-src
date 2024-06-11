extends Node2D




func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("collector"):
		GameManager.death = true
		$AudioStreamPlayer2D.play()
		print("death")
