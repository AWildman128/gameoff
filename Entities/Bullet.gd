extends CharacterBody2D

@onready var direction = (self.global_position - get_global_mouse_position()).normalized()

func _ready():
	#look_at(direction)
	velocity = -direction * 500

func _physics_process(delta):
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy") and not self.is_in_group("Enemy"):
		area.hit(-1)
		self.queue_free()
	elif area.is_in_group("Player") and self.is_in_group("Enemy"):
		area.hit(-1)


func _on_area_2d_body_entered(body):
	self.queue_free()
