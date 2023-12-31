extends Node
class_name HealthComponent

@export var health = 1: set = set_health, get = get_health
@export var entity: CharacterBody2D

func set_health(amount):
	health += amount
	print(health)
	
	if entity:
		if health <= 0:
			print('killed')
			
			if not entity.is_in_group("Player"):
				entity.queue_free()


func get_health():
	return health

func is_alive():
	if health <= 0:
		return false
	else:
		return true
