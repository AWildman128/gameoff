extends Node2D
class_name HealthComponent

@export var health = 0: set = set_health, get = get_health
@export var entity: CharacterBody2D

func set_health(amount):
	health += amount
	print(health)
	if entity:
		if health <= 0:
			entity.queue_free()


func get_health():
	return health
