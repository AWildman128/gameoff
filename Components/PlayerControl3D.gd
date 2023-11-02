extends State
class_name PlayerControl3D

@export var player: CharacterBody3D
@export var speed = 5.0
@export var jump_strength = 4.5
@export var acceleration: Vector3 = Vector3(10,10,50)	# (Acceleration, Deceleration, Fall Speed)
@export var isometric_movement: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func enter():
	if isometric_movement:
		player.rotation_degrees.y = 45


func update(delta):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y -= gravity * delta
	else:
		player.velocity.y = 0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = jump_strength
	elif Input.is_action_just_released("ui_accept") and not player.is_on_floor() and player.velocity.y > 0:
		player.velocity.y = lerp(player.velocity.y, 0.0, 50 * delta)

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var movement_vector = Vector2(player.velocity.x, player.velocity.z)
	var movement_direction = Vector2(direction.x, direction.z)
	
	if movement_direction:
		movement_vector = lerp(movement_vector, movement_direction * speed, acceleration.x * delta)
	else:
		movement_vector = lerp(movement_vector, Vector2.ZERO, acceleration.y * delta)

	player.velocity.x = movement_vector.x
	player.velocity.z = movement_vector.y
	player.move_and_slide()
