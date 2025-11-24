extends Area2D

var value := 20


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.on_pickup(value, self)
