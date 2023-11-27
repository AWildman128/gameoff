extends Node2D


@onready var sprite = $AnimatedSprite2D


func _on_area_2d_body_entered(body):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(global_position.x + 80, global_position.y - 150), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	pass
