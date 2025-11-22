class_name ScreenWrapComponent
extends Node

# Screen margin
@export var margin: float = 20.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var parent = get_parent()
	var screen_size = get_viewport().get_visible_rect().size
	
	# X axis
	if parent.global_position.x > screen_size.x + margin:
		parent.global_position.x = -margin
	elif parent.global_position.x < -margin:
		parent.global_position.x = screen_size.x + margin
	
	# Y axis
	if parent.global_position.y > screen_size.y + margin:
		parent.global_position.y = -margin
	elif parent.global_position.y < -margin:
		parent.global_position.y = screen_size.y + margin
