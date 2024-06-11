extends Node2D
var s
var b
@export var disable = true
@export var player_S : bool
@export var player_b : bool
@export var color : Color
@onready var sprite_2d = $Area2D/Sprite2D



func _process(delta):
	if GameManager.enable:
		disable = false
	else:
		disable = true
	
	if disable:
		$Area2D/CollisionShape2D.disabled = true
		sprite_2d.modulate = Color(255,255,255)
	else:
		$Area2D/CollisionShape2D.disabled = false
		sprite_2d.modulate = color

func _on_area_2d_body_entered(body):
	if player_S:
		if body.is_in_group("player-s"):
			s = true
	elif player_b:
		if body.is_in_group("player-b"):
			b = true


func _on_area_2d_body_exited(body):
	if player_S:
		if body.is_in_group("player-s"):
			s = false
	elif player_b:
		if body.is_in_group("player-b"):
			b = false

