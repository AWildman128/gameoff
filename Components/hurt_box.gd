extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var animation_player: AnimationPlayer


func hit(damage: int = 0):
	if health_component:
		health_component.set_health(damage)
