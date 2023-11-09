extends Node
class_name SnakeJumpComponent

@export var player: CharacterBody2D
@export_range(1,10, 0.1) var strength: float  # Jump strength


func _physics_process(delta):
	if not player.is_on_floor_only():
		player.velocity.y += 15  # Gravity
	elif player.is_on_wall_only():
		player.velocity.y += 0.1 #Slowly slide down wall (does not work?)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.3)  # Floor friction
	
	if Input.is_action_just_pressed("l_click") and (player.is_on_floor() or player.is_on_wall()):
		var direction = player.global_position.direction_to(player.get_global_mouse_position())
		var distance = player.global_position.distance_to(player.get_global_mouse_position())
		distance = clamp(distance, 10, 60)
		
		player.velocity = direction * strength * 60  # Launches snake towards direction of cursor
	elif Input.is_action_just_released("l_click") and not player.is_on_floor() and player.velocity.y < 0:
		player.velocity.y = lerp(player.velocity.y, 0.0, 0.5)  # Controls how suddenly the snake falls after mouse is released
		
	player.move_and_slide()
