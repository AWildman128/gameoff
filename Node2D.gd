extends Node2D

@onready var tween = self.create_tween()


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_center = get_viewport_rect().size/2
	var positions = [screen_center.x - 20, screen_center.x + 20]
	tween.set_loops()
	tween.tween_property($Sprite2D, "position", Vector2(positions[0],screen_center.y), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "position", Vector2(positions[1],screen_center.y), 1).set_trans(Tween.TRANS_SINE)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
