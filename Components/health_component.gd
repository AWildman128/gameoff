extends Node
class_name HealthComponent

@export var health = 1: set = set_health, get = get_health
@export var entity: CharacterBody2D
@onready var death_effect: GPUParticles2D = preload("res://Materials/DeathParticles.tscn").instantiate()

@export var weapon: Node2D
@export var hurt_box: HurtboxComponent
@export var collision: CollisionShape2D
@export var sound_component: SoundComponent

signal dead


func _ready():
	if not hurt_box: hurt_box = HurtboxComponent.new()
	if not collision: collision = CollisionShape2D.new()

func set_health(amount):
	health += amount
	print(health)
	
	if entity:
		if health <= 0:
			print('killed')
			
			if not entity.is_in_group("Player"):
				entity.velocity.y = -100
				dead.emit()
				sound_component.play("Death")
				if weapon: weapon.data = weapon.empty
				entity.remove_child(collision)
				hurt_box.monitorable = false
				hurt_box.monitoring = false
				hurt_box.queue_free()
				
			else:
				sound_component.play("Death", true, -5)
				death_effect.one_shot = true
				death_effect.emitting = true
				entity.add_child(death_effect)
				await get_tree().create_timer(0.2).timeout
				LevelManager.reload_scene()


func get_health():
	return health

func is_alive():
	if health <= 0:
		return false
	else:
		return true
