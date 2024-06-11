extends Node


var coin_finish = false
var enable = false
var death = false
var reload_scene = false
var player_dis = 0
var coin_collected
var vib = false
var pitch = 1
var death_count = 0

var s = 0
var m = 0
var gameover = false
var fade =true
func _process(delta):
	$AudioStreamPlayer2.pitch_scale = pitch
	if coin_finish:
		enable = true
	else :
		enable = false
	if death:
		death = false
	if s >= 60:
		m +=1
		s = 0
	#print("%02d:%02d" % [m,s])
	if gameover:
		$Timer.paused = true
	else:
		$Timer.paused = false
	if reload_scene:
		death_count +=1
	if Input.is_anything_pressed():
		if fade:
			$AnimationPlayer.play("fade")


func start_play():
	if fade:
		$CanvasLayer.show()
	$AudioStreamPlayer2.play()
	$AudioStreamPlayer3.play()
	$AudioStreamPlayer2.volume_db = -5
	$AudioStreamPlayer3.volume_db = -5
	randomize()
	$AudioStreamPlayer.play()
	pitch = randf_range(0.6,0.9)
	$AudioStreamPlayer.pitch_scale = pitch



func _on_timer_timeout():
	s+=1


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade":
		fade = false
		$CanvasLayer.queue_free()
