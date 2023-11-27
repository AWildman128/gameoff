extends Node2D


@onready var sprite = $AnimatedSprite2D
@onready var tween: Tween = get_tree().create_tween()


func _ready():
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)


func _on_area_2d_body_entered(body):
	tween.tween_property(self, "position", Vector2(10, -100), 10).set_ease(Tween.EASE_IN)
	pass
