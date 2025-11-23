@tool
extends RigidBody2D

enum ShapeType { TRIANGLE, SQUARE, CIRCLE}

@export var shape_type: ShapeType = ShapeType.CIRCLE:
	set(val):
		shape_type = val
		queue_redraw()
		
@export var radius: float = 80.0:
	set(val):
		radius = val
		queue_redraw()

@export var next_tier_scene: PackedScene


func _ready():
	# This tells Godot to run the _draw() function once at the start
	queue_redraw()

func _draw():
	var color = Color.WHITE
	var width = 2.0
	
	match shape_type:
		ShapeType.TRIANGLE:
			draw_pyramid_shape(color, width)
		ShapeType.SQUARE:
			draw_square_shape(color, width)
		ShapeType.CIRCLE:
			draw_arc(Vector2.ZERO, radius, 0, TAU, 32, color, width)

# Helper function to keep _draw clean
func draw_pyramid_shape(col, w):
	# Using the pyramid logic we discussed, scaling by 'radius'
	# We treat 'radius' as height here for simplicity
	var points = PackedVector2Array([
		Vector2(0, -radius),         # Top
		Vector2(radius * 0.6, radius), # Bottom Right
		Vector2(-radius * 0.6, radius),# Bottom Left
		Vector2(0, -radius)          # Close loop
	])
	draw_polyline(points, col, w)

func draw_square_shape(col, w):
	var rect = Rect2(-radius, -radius, radius * 2, radius * 2)
	draw_rect(rect, col, false, w)

func explode():
	# 1. Check if there is a smaller version to spawn
	if next_tier_scene != null:
		# Spawn 2 smaller asteroids
		for i in range(2):
			spawn_next_tier()
	
	queue_free() # Destroy self

func spawn_next_tier():
	var new_asteroid = next_tier_scene.instantiate()
	
	# Set position to current parent's position
	new_asteroid.global_position = global_position
			
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	new_asteroid.linear_velocity = velocity.rotated(rotation)
	# Add to the game world
	get_parent().call_deferred("add_child", new_asteroid)
	
	# Optional: Push them apart slightly so they don't overlap instantly
	new_asteroid.linear_velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))
