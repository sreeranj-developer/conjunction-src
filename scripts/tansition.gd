extends Control


func play_in():
	$AnimationPlayer.play("in")
	$AudioStreamPlayer.play()
func play_out():
	$AnimationPlayer.play("out")
	$AudioStreamPlayer.play()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "in":
		queue_free()
