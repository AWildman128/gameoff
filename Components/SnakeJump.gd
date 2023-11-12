extends Node
class_name SnakeJumpComponent

@export var player: CharacterBody2D
@export var area: Area2D
@export_range(1,10, 0.1) var strength: float  # Jump strength

var grabbing = false
var grab_target: HurtboxComponent


func _ready():
	if not area: area = Area2D.new()
	area.connect("area_entered", on_area_entered)
	area.connect("area_exited", on_area_exited)


func _physics_process(delta):
	if not player.is_on_floor_only():
		player.velocity.y += 15  # Gravity
	elif player.is_on_wall_only():
		player.velocity.y += 0.1 #Slowly slide down wall (does not work?)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.3)  # Floor friction
	
	if Input.is_action_just_pressed("l_click") and (player.is_on_floor() or grabbing or player.is_on_wall()):
		var direction = player.global_position.direction_to(player.get_global_mouse_position())
		var distance = player.global_position.distance_to(player.get_global_mouse_position())
		distance = clamp(distance, 10, 60)
		
		player.velocity = direction * strength * 60  # Launches snake towards direction of cursor
		
		if grabbing and grab_target:
			grab_target.hit(-1)
			grabbing = false
			grab_target = null
			
	elif Input.is_action_just_released("l_click") and not player.is_on_floor() and player.velocity.y < 0:
		player.velocity.y = lerp(player.velocity.y, 0.0, 0.5)  # Controls how suddenly the snake falls after mouse is released
		
	player.move_and_slide()
	
	if grabbing and grab_target:
		player.global_position = grab_target.global_position


func on_area_entered(area):
	grabbing = true
	grab_target = area


func on_area_exited(area):
	pass









