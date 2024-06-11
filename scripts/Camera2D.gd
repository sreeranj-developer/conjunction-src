extends Camera2D


@export var shake_duration = 0.5
@export var shake_magnitude = 10.0

var is_shaking = false
var original_position = Vector2()
var shake_timer = 0.0
var follow = true




func shake_screen(duration: float, magnitude: float):
	if not is_shaking:
		shake_duration = duration
		shake_magnitude = magnitude
		shake_timer = shake_duration
		is_shaking = true

func _process(delta: float):
	if is_shaking:
		shake_timer -= delta
		if shake_timer > 0:

			var offset = Vector2(randf_range(-shake_magnitude, shake_magnitude),randf_range(-shake_magnitude, shake_magnitude))
			position = position + offset
		else:
			is_shaking = false

func _physics_process(delta):
	if GameManager.death:
		self.shake_screen(0.1,3)
	if follow:
		var pos = ($"../player-small".global_transform.origin + $"../player-big".global_transform.origin)/2
		self.global_transform.origin = lerp(self.global_transform.origin,pos,0.1)
		if GameManager.player_dis < 1000:
			self.zoom = lerp(self.zoom,Vector2(0.6,0.6),0.05)
		else:
			self.zoom = lerp(self.zoom,Vector2(0.4,0.4),0.05)

