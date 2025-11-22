@tool
extends RigidBody2D

var asteroid_tier:= 3
@export var size:= 80.0


func _ready():
	# This tells Godot to run the _draw() function once at the start
	queue_redraw() 

func _draw():
	var points = PackedVector2Array([
		Vector2(size, -size),   # Top Right
		Vector2(size,size),  # Bottom Right
		Vector2(-size,size),  # Bottom Left
		Vector2(-size,-size),  # Top Left
		Vector2(size,-size),  # Close loop
	])
	# draw_polyline(points, color, width)
	draw_polyline(points, Color.WHITE, 2.0)
