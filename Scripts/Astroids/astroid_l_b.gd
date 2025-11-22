@tool
extends RigidBody2D

var asteroid_tier:= 3

func _ready():
	# This tells Godot to run the _draw() function once at the start
	queue_redraw() 

func _draw():
	var points = PackedVector2Array([
		Vector2(0, -80),   # Top point
		Vector2(-70, 40),  # Bottom Left
		Vector2(70, 40),   # Bottom Right
		Vector2(0, -80)    # Top point again (to close the loop)
	])
	# draw_polyline(points, color, width)
	draw_polyline(points, Color.WHITE, 2.0)
