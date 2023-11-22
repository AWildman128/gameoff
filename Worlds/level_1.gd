extends Node2D


func _on_area_2d_body_entered(body):

	if body.is_in_group("Player"):
		SceneChanger.change_scene("res://Worlds/level_2.tscn")
