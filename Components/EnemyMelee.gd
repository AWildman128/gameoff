extends State
class_name EnemyMelee

@export var enemy: CharacterBody2D
@export var move_speed: int
@export var wander: State
@export var detection_distance = 50
@export var animation_player: AnimationPlayer

var player: Node2D

func enter():
	player = get_tree().get_first_node_in_group("Player")


func update(delta):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 12 and not animation_player.is_playing():
		enemy.velocity.x = round(direction.normalized().x) * move_speed
	else:
		enemy.velocity.x = 0
		if animation_player:
			animation_player.play("Attack")

	if direction.length() > detection_distance:
		transition.emit(self, wander.name)
	
	enemy.move_and_slide()

