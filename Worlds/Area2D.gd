extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		LevelManager.change_scene(preload("res://Worlds/Credits.tscn"))
