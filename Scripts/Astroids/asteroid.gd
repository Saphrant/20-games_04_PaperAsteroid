@tool
extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var asteroid_array : Array[AtlasTexture]
@export_range(1,3) var asteroid_tier:= 1



func _ready():
	GameManager.asteroid_hit.connect(_on_asteroid_hit)
	sprite_2d.texture = asteroid_array.pick_random()

func explode():
	pass

func _on_asteroid_hit(body):
	pass
