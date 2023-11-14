extends Node

@export var player: CharacterBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player.is_on_floor_only():
		pass
