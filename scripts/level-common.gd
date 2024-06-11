extends Node2D


@export var next_scene : PackedScene
@onready var player_s = $end
@onready var player_b = $end2
var total_coin = 0
var coin = 0 
var max_val1 = 0
var max_val2 = 0
func _ready():
	$CanvasLayer/Control/tansition.play_in()
	GameManager.start_play()
	GameManager.reload_scene = false
	GameManager.enable = false
	GameManager.coin_collected = 0
	GameManager.death = false
	Engine.time_scale =1
	coin = $coins.get_child_count()
	max_val1 = $end.global_position.distance_to($"player-small".global_position)
	max_val2 = $end2.global_position.distance_to($"player-big".global_position)


func  _process(delta):
	var progress_val1 = $end.global_position.distance_to($"player-small".global_position)
	var progress_val2 = $end2.global_position.distance_to($"player-big".global_position)
	$"player-small".progress_value(progress_val1,max_val1)
	$"player-big".progress_value(progress_val2,max_val2)
	total_coin = $coins.get_child_count()
	if total_coin <= 0:
		GameManager.coin_finish = true
	else:
		GameManager.coin_finish = false
	if player_s.s == true and player_b.b == true:
		if next_scene:
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_packed(next_scene)
		player_s.s = false
		player_b.b = false
	if Input.is_key_pressed(KEY_R) or GameManager.reload_scene == true:
		get_tree().reload_current_scene()
