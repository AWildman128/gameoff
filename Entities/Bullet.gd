extends CharacterBody2D

@onready var direction = (self.global_position - get_global_mouse_position()).normalized()

func _ready():
	velocity = -direction * 500

func _physics_process(delta):
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		area.hit(-1)
		self.queue_free()


func _on_area_2d_body_entered(body):
	self.queue_free()
