extends State
class_name EnemyRanged

@onready var enemy: CharacterBody2D
@export var wander: State
@export var weapon: Node2D
@export var detection_distance = 50

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
	
	if direction.length() > detection_distance:
		transition.emit(self, wander.name)
		return
	
	if weapon:
		weapon.shoot(direction)
		shooting = true


func finished_shooting():
	shooting = false
	shoot()
