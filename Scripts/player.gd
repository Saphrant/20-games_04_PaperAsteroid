extends CharacterBody2D

#---- Constants
const MAX_AMMO:= 60
const HYPERSPACE_COST:= 30

#----- Timers
@onready var reload_timer: Timer = $ReloadTimer
@onready var hyper_space_timer: Timer = $HyperSpaceTimer
@onready var resurface_timer: Timer = $ResurfaceTimer

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

@export var bullet_scene: PackedScene
@export var shield_scene: PackedScene

@export_category("Player Properties")
@export var rotation_speed := 4.0
@export var thrust_power := 300.0
@export var max_speed := 200.0
@export var friction := 0.9

var screen_size: Vector2

var bullets_remaining:= MAX_AMMO


func _ready() -> void:
	GameManager.picked_up.connect(_on_pickup)
	screen_size = get_viewport_rect().size
	_spawn_shield()
	

func _physics_process(delta):
	var rotation_dir = Input.get_axis("left", "right")
	rotation += rotation_dir * rotation_speed * delta
	var force = Vector2.UP.rotated(rotation) * thrust_power
	# THRUST
	if Input.is_action_pressed("thrust"):
		velocity += force * delta
		# Clam velocity by limit_length
		velocity = velocity.limit_length(max_speed)
	if Input.is_action_pressed("reverse"):
		velocity += -force * delta
		# Clam velocity by limit_length
		velocity = velocity.limit_length(max_speed)
	
	# FRICTION
	if not Input.is_action_pressed("thrust"):
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	# SHOOT
	if Input.is_action_pressed("shoot"):
		if reload_timer.time_left == 0 and bullets_remaining != 0:
			reload_timer.start()
			_shoot()
		
	if Input.is_action_just_pressed("hyperspace"):
		if hyper_space_timer.time_left == 0 and bullets_remaining > 30:
			collision_polygon_2d.disabled = false
			var jump_tween: Tween
			jump_tween = create_tween()
			jump_tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
			jump_tween.tween_callback(hide).set_delay(0.2)
			bullets_remaining -= 30
			resurface_timer.start()
			hyper_space_timer.start()
	move_and_slide()

func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.pos = marker_2d.global_position
	bullet.rot = global_rotation
	bullet.dir = rotation + deg_to_rad(-90)
	get_parent().add_child(bullet)
	cpu_particles_2d.emitting = true
	bullets_remaining -= 1
	texture_progress_bar.value = bullets_remaining
	
func _on_pickup(value: int, item_ref: Area2D) -> void:
	if bullets_remaining < MAX_AMMO:
		bullets_remaining += value
		bullets_remaining = clampi(bullets_remaining,0,MAX_AMMO)
		texture_progress_bar.value = bullets_remaining
		item_ref.queue_free()


func _on_resurface_timer_timeout() -> void:
	var random_x = randf_range(40, screen_size.x - 40)
	var random_y = randf_range(120, screen_size.y - 40)
	global_position.x = random_x
	global_position.y = random_y
	texture_progress_bar.value = bullets_remaining
	var resurface_tween: Tween
	resurface_tween = create_tween()
	resurface_tween.tween_callback(show).set_delay(0.2)
	resurface_tween.tween_property(self, "scale", Vector2.ONE, 0.5)
	resurface_tween.tween_property(collision_polygon_2d, "disabled", false, 0.1).set_delay(0.2)

func _spawn_shield() -> void:
	var shield = shield_scene.instantiate()
	add_child(shield)
