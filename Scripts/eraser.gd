extends CharacterBody2D

@export var speed := 100.0
var target = null
func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var direction = (target.position - position).normalized()
	velocity = (direction * speed)
	look_at(target.position)
	move_and_slide()
