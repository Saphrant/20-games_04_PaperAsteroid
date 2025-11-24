extends Node

# --- Asteroid hits
signal asteroid_hit
signal picked_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_asteroid_hit(body):
	asteroid_hit.emit(body)

func on_pickup(value, item):
	picked_up.emit(value, item)
