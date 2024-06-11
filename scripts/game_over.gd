extends Control



func _ready():
	GameManager.gameover = true
	$tansition.play_in()

func _process(delta):
	$Panel/Label2.text = "Time Taken: %02d:%02d" % [GameManager.m,GameManager.s]
	$Panel/Label3.text = "Deaths: "+str(GameManager.death_count)


func _on_button_pressed():
	GameManager.s = 0
	GameManager.m = 0
	GameManager.gameover = false
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
