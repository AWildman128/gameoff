extends Control


@onready var credits = $RichTextLabel


func _ready():
	var tween = self.create_tween()
	tween.tween_property(credits, "global_position", Vector2(credits.global_position.x, -(credits.global_position.y + credits.size.y)), 30)
	tween.tween_callback(main_menu)
	tween.play()


func main_menu():
	LevelManager.change_scene(preload("res://Worlds/main_menu.tscn"))
