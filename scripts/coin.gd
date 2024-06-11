extends Node2D



func _physics_process(delta):
	pass




func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("collector"):
		GameManager.coin_collected += 1
		$Area2D/AnimationPlayer.play("fade")
		$AudioStreamPlayer2D.play()


func _on_audio_stream_player_2d_finished():
	queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade":
		queue_free()
