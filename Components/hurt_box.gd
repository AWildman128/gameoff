extends Area2D
class_name HurtboxComponent

@export var entity: CharacterBody2D
@export var health_component: HealthComponent
@export var animation_player: AnimationPlayer

var fling_strength: int = 10


func hit(damage: int = 0) -> void:
	if health_component:
		health_component.set_health(damage)
