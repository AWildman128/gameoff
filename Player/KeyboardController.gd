extends Node
class_name KeyboardController

@export var player: CharacterBody2D
@export var speed: int = 1
@export var amplitude = 110
@export var frequency = 0.008

@onready var tween: Tween = self.get_tree().create_tween()

var time = 0

func _ready():
	if not player: player = CharacterBody2D.new()
	

func _physics_process(delta):
	var direction: Vector2
	if InputManager.input_type == InputManager.CONTROLLER:
		direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	elif InputManager.input_type == InputManager.KBM:
		direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))

	direction = direction.normalized()
	
	
	
	if abs(direction.x) >= 0.5 and player.is_on_floor():
		player.velocity.x = speed
		# Update the time variable based on delta time
		var time = Time.get_ticks_msec()
		# Calculate the scale factor using the sine function
		var scale_factor = abs(sin(time * frequency))

		# Adjust the player's velocity based on the scale factor
		player.velocity.x = direction.x * scale_factor * amplitude * speed
	
		#print(scale_factor)
	
