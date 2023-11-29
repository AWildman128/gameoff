extends State
class_name EnemyRanged

@export var enemy: CharacterBody2D
@export var wander: State
@export var weapon: Node2D
@export var detection_distance = 50
@export var sprite: Sprite2D

var player: CharacterBody2D
var shooting = false


func enter():
	player = get_tree().get_first_node_in_group("Player")
	if weapon:
		weapon.connect("finished_shooting", finished_shooting)
	shoot()


func shoot():
	if shooting: return
	
	var direction = player.global_position - enemy.global_position
	sprite.flip_h = not clamp(round(direction.x), 0, 1)
	
	if direction.length() > detection_distance:
		shooting = false
		weapon.shoot()
		transition.emit(self, wander.name)
		return
	
	if weapon:
		weapon.shoot(player)
		shooting = true


func finished_shooting():
	print('finished shooting')
	shooting = false
	shoot()
