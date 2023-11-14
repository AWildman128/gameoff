extends Node
class_name KeyboardController

@export var player: CharacterBody2D
@export var speed: int = 50
@export_range(1,10, 0.1) var strength: float  # Jump strength
@export var area: Area2D

var grabbing = false
var grab_target: HurtboxComponent
var wall_jumps = 1


func _ready():
	if not area: area = Area2D.new()
	area.connect("area_entered", on_area_entered)
	area.connect("area_exited", on_area_exited)
	
	if not player: player = CharacterBody2D.new()


func _physics_process(delta):
	if not player.is_on_floor_only() and not player.is_on_wall():
		player.velocity.y += 20  # Gravity
	elif player.is_on_wall_only():
		player.velocity.y = lerp(player.velocity.y, 30.0, 0.1)  # Slowly slide down wall (does work)
		player.velocity.x = -player.get_wall_normal().x
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.1)  # Floor friction
	
	var direction = Vector2((Input.get_action_strength("right")-Input.get_action_strength("left")) /2, (Input.get_action_strength("down") - Input.get_action_strength("up")) * sqrt(3)/2)
	direction = direction.normalized()
	#player.velocity.x = direction.x * speed
	print(direction)
	
	if Input.is_action_just_pressed("ui_accept") and (player.is_on_floor() or grabbing or (player.is_on_wall() and wall_jumps > 0)):
		if not player.is_on_wall_only():
			player.velocity = direction * strength * 60  # Launches snake towards direction of cursor
		elif player.is_on_wall_only():
			var dir = player.get_wall_normal().normalized()
			if direction.y > 0:
				dir.y = -1
			elif direction.y < 0:
				dir.y = 1
			#print(dir)
			player.velocity = Vector2(0.5 * dir.x,-1*dir.y) * -strength * 200  # Launches snake towards direction of cursor
	
	player.move_and_slide()
	
	if grabbing and grab_target:
		player.global_position = grab_target.global_position


func on_area_entered(area):
	if area.is_in_group("Enemy"):
		grabbing = true
		grab_target = area


func on_area_exited(area):
	pass









