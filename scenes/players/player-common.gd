extends CharacterBody2D


var SPEED = 750.0
var JUMP_VELOCITY = 700.0
var gravity = 980
var push_force = 80.0
@onready var sprite_2d = $Sprite2D
@onready var shape_cast_2d = $ShapeCast2D
@onready var collision_shape_2d = $CollisionShape2D
var players
func _ready():
	players = get_tree().get_nodes_in_group("player")

func _physics_process(delta):
	rigid_push()
	var direction = Input.get_axis("ui_left", "ui_right")
	if not shape_cast_2d.is_colliding():
		velocity.y += gravity * delta
		if velocity.x > 0:
			sprite_2d.rotation += 5 * delta
		elif velocity.x < 0:
			sprite_2d.rotation -= 5 * delta
		else:
			sprite_2d.rotation += 5 * delta
		collision_shape_2d.disabled = true
	else:
		sprite_2d.rotation = 0
		collision_shape_2d.disabled = false
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		collision_shape_2d.disabled = false
	
	if Input.is_action_just_pressed("ui_accept") and shape_cast_2d.is_colliding():
		$AudioStreamPlayer2D.play()
		GameManager.vib = true
		velocity.y = JUMP_VELOCITY
	else:
		GameManager.vib = false

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.15)
	
	if self.position.y > 540:
		JUMP_VELOCITY = 700
		gravity = -980
		shape_cast_2d.rotation_degrees = 180
	elif self.position.y < 540:
		JUMP_VELOCITY = -700
		gravity = 980
		shape_cast_2d.rotation_degrees = 0
	move_and_slide()
	
	GameManager.player_dis = players[0].global_position.distance_to(players[1].global_position)
	$CPUParticles2D.gravity.y = gravity
	if GameManager.death:
		$Sprite2D.hide()
		$CollisionShape2D.disabled = true
		$CPUParticles2D.emitting = true
		GameManager.pitch = 0.2
		Engine.time_scale = 0.05
		await get_tree().create_timer(0.1).timeout		
		GameManager.reload_scene = true
		
func rigid_push():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func progress_value(val,max_val):
	$CanvasLayer/Control/ProgressBar.value = val
	$CanvasLayer/Control/ProgressBar.max_value = max_val
