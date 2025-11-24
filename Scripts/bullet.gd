extends Area2D

@export var radius = 20.0
@export var bullet_speed := 800.0
@export var bullets : Array[AtlasTexture]
@onready var sprite_2d: Sprite2D = $Sprite2D

var pos: Vector2 	#Position
var rot: float		#Rotation
var dir: float		#Direction

func _ready():
	global_position = pos
	global_rotation = rot
	sprite_2d.texture = bullets.pick_random()

func _physics_process(delta: float) -> void:
	position += Vector2(bullet_speed,0).rotated(dir) * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	GameManager.on_asteroid_hit(body)
	#queue_free()
