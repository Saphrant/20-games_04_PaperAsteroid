extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var respawn_timer: Timer = $RespawnTimer

var health:= 100.0

func _physics_process(_delta: float) -> void:
	global_rotation = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("asteroid"):
		if health > 35:
			health -= 35
			sprite_2d.material.set_shader_parameter('percentage', (health/100))
			print(health)
			body.queue_free()
		elif health < 35:
			print("dead")
			hide()
			respawn_timer.start()


func _on_respawn_timer_timeout() -> void:
	show()
	print("showing")
	var tween = create_tween()
	tween.tween_method(set_percent, 0.0, 1.0, 4)
	health = 100
	
func set_percent(percentage: float) -> void:
	sprite_2d.material.set_shader_parameter('percentage', percentage)
	
