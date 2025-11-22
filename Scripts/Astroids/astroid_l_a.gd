@tool
extends RigidBody2D

var asteroid_tier:= 3

func _ready():
	# This tells Godot to run the _draw() function once at the start
	queue_redraw() 

func _draw():
	var radius = 40.0 # Easy to change for Large/Medium/Small
	# draw_arc(center, radius, start_angle, end_angle, point_count, color, width)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 32, Color.WHITE, 2.0)
