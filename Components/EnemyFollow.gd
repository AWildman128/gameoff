extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed: int

var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	
	enemy.velocity.y -= 300


func update(delta):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 32:
		enemy.velocity = direction.normalized() * move_speed

	if direction.length() > 150:
		transition.emit(self, "enemywander")

