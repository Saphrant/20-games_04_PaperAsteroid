extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation

@export var large_asteroid_scene: Array[PackedScene]

var number_of_asteroids: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.large_hit.connect(_on_large_hit)
	GameManager.medium_hit.connect(_on_medium_hit)
	GameManager.small_hit.connect(_on_small_hit)
	spawn_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_spawn_timer_timeout() -> void:
	if large_asteroid_scene.size() > 0 and number_of_asteroids < 6:
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
  
func _on_large_hit(pos) -> void:
	number_of_asteroids -= 1
	print("hit large at: ", pos)
	
func _on_medium_hit(pos) -> void:
	pass
	
func _on_small_hit(pos) -> void:
	pass
