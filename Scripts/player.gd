extends CharacterBody2D

@onready var reload_timer: Timer = $ReloadTimer

@export var bullet_scene: PackedScene

var rotation_speed := 5.0
var thrust_power := 500.0
var max_speed := 500.0
var friction := 0.75

func _physics_process(delta):
	var rotation_dir = Input.get_axis("left", "right")
	rotation += rotation_dir * rotation_speed * delta
	var force = Vector2.UP.rotated(rotation) * thrust_power
	# THRUST
	if Input.is_action_pressed("thrust"):
		velocity += force * delta
		# Clam velocity by limit_length
		velocity = velocity.limit_length(max_speed)
	
	# FRICTION
	if not Input.is_action_pressed("thrust"):
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	# SHOOT
	if Input.is_action_pressed("shoot") and reload_timer.time_left <= 0:
		reload_timer.start()
		_shoot()
		
	move_and_slide()

func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.pos = global_position
	bullet.rot = global_rotation
	bullet.dir = rotation + deg_to_rad(-90)
	get_parent().add_child(bullet)
	
