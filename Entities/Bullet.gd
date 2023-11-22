extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

var direction = Vector2.LEFT
var life_time: float = 1


func _ready():
	velocity = -direction * 400
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color(1,1,1,0), life_time).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(life_time).timeout
	self.queue_free()
	

func _physics_process(delta):
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy") and not self.is_in_group("Enemy"):
		area.hit(-1)
		self.queue_free()
	elif area.is_in_group("Player") and self.is_in_group("Enemy"):
		area.hit(-1)


func _on_area_2d_2_body_entered(body):
	self.queue_free()
