extends Node
class_name SnakeJumpComponent

@export var player: CharacterBody2D
@export var area: Area2D
@export_range(1,10, 0.1) var strength: float  # Jump strength
@export var health_component: HealthComponent
@onready var weapon = $"../Weapon"

var grabbing = false
var grab_target: HurtboxComponent
var wall_jumps = 1

const WALK_SPEED = 15
const SPEED_CAP = 400


func _ready():
	if not area: area = Area2D.new()
	area.connect("area_entered", on_area_entered)
	area.connect("area_exited", on_area_exited)


func _physics_process(delta):
	#print(player.velocity)
	
	if not player.is_on_floor_only() and not player.is_on_wall():
		player.velocity.y += 20  # Gravity
	elif player.is_on_wall_only():
		player.velocity.y = lerp(player.velocity.y, 30.0, 0.1)  # Slowly slide down wall (does work)
		player.velocity.x = -player.get_wall_normal().x
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.2)  # Floor friction

	if not health_component.is_alive(): return
	
	if Input.is_action_just_pressed("jump") and (player.is_on_floor() or grabbing or (player.is_on_wall() and wall_jumps > 0)):
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
				dir.y = 0
			elif direction.y < 0:
				dir.y = 1
			
			direction.y = clamp(direction.y, -0.5, 0)
			
			player.velocity = Vector2(0.5 * dir.x,direction.y*1.5) * strength * 70  # Launches snake towards direction of cursor
		
		if grabbing and grab_target:
			grab_target.hit(-1)
			grabbing = false
			grab_target = null
			
	elif Input.is_action_just_released("jump") and not player.is_on_floor() and player.velocity.y < 0:
		var tween = get_tree().create_tween()
		tween.tween_property(player, "velocity", Vector2(player.velocity.x, 0.0), 0.02).set_ease(Tween.EASE_IN)
		#tween.kill()
		#player.velocity.y = lerp(player.velocity.y, 0.0, 1)  # Controls how suddenly the snake falls after mouse is released
	elif Input.is_action_pressed("left"):
		player.velocity.x = lerp(player.velocity.x, -strength * 60/2, 0.2)
	elif Input.is_action_pressed("right"):
		player.velocity.x = lerp(player.velocity.x, strength * 60/2, 0.2)
	
	player.velocity = player.velocity.limit_length(SPEED_CAP)
	
	player.move_and_slide()
	
	if grabbing and grab_target:
		if not grab_target.is_queued_for_deletion():
			grab_target.monitorable = false
			player.global_position = grab_target.global_position


func on_area_entered(area):
	if area.is_in_group("Enemy"):
		grabbing = true
		grab_target = area
	if area.is_in_group("Weapon"):
		print('weapon')


func on_area_exited(area):
	pass









