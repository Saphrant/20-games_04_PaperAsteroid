extends Node

# --- Asteroid hits
signal large_hit
signal medium_hit
signal small_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_large_hit(body, pos):
	body.queue_free()
	large_hit.emit(pos)
	
func on_medium_hit(pos):
	medium_hit.emit(pos)
	
func on_small_hit(pos):
	small_hit.emit(pos)
