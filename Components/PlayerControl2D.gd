extends State
class_name PlayerControl2D

@export var player: CharacterBody2D
@export var speed = 5.0
@export var jump_strength = 4.5
@export var acceleration: Vector3 = Vector3(10,10,50)	# (Acceleration, Deceleration, Fall Speed)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func update(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	#print(abs(round(direction)))
	if direction.x:
		player.velocity.x = lerp(player.velocity.x, direction.x * speed, acceleration.x * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, acceleration.y * delta)
	
	# Add the gravity.
	if player.is_on_floor():
		player.velocity.y = 0
	else:
		player.velocity.y += gravity * delta * acceleration.z

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = -jump_strength
	# Handle Fall
	if Input.is_action_just_released("ui_accept") and not player.is_on_floor() and player.velocity.y < 0:
		player.velocity.y = lerp(player.velocity.y, 0.0, acceleration.z * delta)
	
	player.move_and_slide()
