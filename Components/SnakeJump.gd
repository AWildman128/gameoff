extends Node
class_name SnakeJumpComponent

@export var player: CharacterBody2D
@export var area: Area2D
@export_range(1,10, 0.1) var strength: float  # Jump strength

var grabbing = false
var grab_target: HurtboxComponent
var wall_jumps = 1


func _ready():
	if not area: area = Area2D.new()
	area.connect("area_entered", on_area_entered)
	area.connect("area_exited", on_area_exited)


func _physics_process(delta):
	if not player.is_on_floor_only() and not player.is_on_wall():
		player.velocity.y += 20  # Gravity
	elif player.is_on_wall_only():
		player.velocity.y = lerp(player.velocity.y, 30.0, 0.1)  # Slowly slide down wall (does work)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.1)  # Floor friction
	
	if Input.is_action_just_pressed("l_click") and (player.is_on_floor() or grabbing or (player.is_on_wall() and wall_jumps > 0)):
		var direction = player.global_position.direction_to(player.get_global_mouse_position())
		var distance = player.global_position.distance_to(player.get_global_mouse_position())
		distance = clamp(distance, 10, 60)
		#direction.y = clamp(direction.y, -0.01, -1)
		#print(direction)
		
		if not player.is_on_wall_only():
			player.velocity = direction * strength * 60  # Launches snake towards direction of cursor
		elif player.is_on_wall_only():
			var dir = player.get_wall_normal().normalized()
			if direction.y > 0:
				dir.y = -1
			elif direction.y < 0:
				dir.y = 1
			#print(dir)
			player.velocity = Vector2(0.5 * dir.x,-1*dir.y) * strength * 62  # Launches snake towards direction of cursor
		
		if grabbing and grab_target:
			grab_target.hit(-1)
			grabbing = false
			grab_target = null
			
	elif Input.is_action_just_released("l_click") and not player.is_on_floor() and player.velocity.y < 0:
		var tween = get_tree().create_tween()
		tween.tween_property(player, "velocity", Vector2(player.velocity.x, 0.0), 0.05).set_ease(Tween.EASE_IN)
		#tween.kill()
		#player.velocity.y = lerp(player.velocity.y, 0.0, 1)  # Controls how suddenly the snake falls after mouse is released
		
	player.move_and_slide()
	
	if grabbing and grab_target:
		player.global_position = grab_target.global_position


func on_area_entered(area):
	grabbing = true
	grab_target = area


func on_area_exited(area):
	pass









