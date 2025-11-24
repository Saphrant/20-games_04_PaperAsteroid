extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation
@onready var pick_up_timer: Timer = $PickUpTimer
@onready var ink_bottles: Node = $InkBottles

@export var large_asteroid_scene: Array[PackedScene]
@export var ink_bottle_scene: PackedScene

var number_of_asteroids: int
var screen_size: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	spawn_timer.start()
	
func _on_spawn_timer_timeout() -> void:
	if large_asteroid_scene.size() > 0 and number_of_asteroids < 6:
		spawn_large_asteroids()

func spawn_large_asteroids() -> void:
		# Create a new instance of the Asteroid scene.
			var asteroid_array = large_asteroid_scene.pick_random()
			var asteroid = asteroid_array.instantiate() as RigidBody2D
			
			# Choose a random location on Path2D.
			spawn_location.progress_ratio = randf()
			
			# Set the Asteroids position to the random location.
			asteroid.position = spawn_location.position
			
			# Set the Asteroid direction perpendicular to the path direction.
			var direction = spawn_location.rotation + PI / 2
			
			# Add some randomness to the direction.
			direction += randf_range(-PI / 4, PI / 4)
			asteroid.rotation = direction
			
			# Choose the velocity for the mob.
			var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
			asteroid.linear_velocity = velocity.rotated(direction)
			
			add_child(asteroid)
			number_of_asteroids += 1


func spawn_ink_bottle() -> void:
	var ink_bottle = ink_bottle_scene.instantiate() as Area2D
	var random_location_x = randf_range(0, screen_size.x - 40)
	var random_location_y = randf_range(120, screen_size.y - 40)
	ink_bottle.position.x = random_location_x
	ink_bottle.position.y = random_location_y
	ink_bottles.add_child(ink_bottle)
	


func _on_pick_up_timer_timeout() -> void:
	var remaining_ink_bottles := ink_bottles.get_children()
	var rng = randf()
	if rng < 0.4 and remaining_ink_bottles.size() < 2:
		spawn_ink_bottle()
		
