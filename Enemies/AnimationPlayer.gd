extends AnimationPlayer
class_name EnemyAnimator

@export var enemy: CharacterBody2D
@export var sprite: Sprite2D
@export var health_component: HealthComponent


func _ready():
	health_component.connect("dead", on_death)
	

func on_death():
	self.stop()
	self.play("Death")
	print("fuck im dead")
