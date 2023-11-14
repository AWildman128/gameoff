extends Node

@export var player: CharacterBody2D

var foo = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player.is_on_floor():
		var direction = player.global_position.direction_to(player.get_global_mouse_position())
		var distance = player.global_position.distance_to(player.get_global_mouse_position())
		direction = direction.normalized()
		
		player.velocity.x += direction.x * 10
