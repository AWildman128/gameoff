extends State
class_name EnemyWander

@export var enemy: CharacterBody2D
@export var move_speed = 10
@export var detection_distance = 50
@export var attack_state: State
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D

var move_direction: Vector2
var wander_time: float
var player: Node2D


func randomize_wander():
	move_direction = Vector2(randi_range(-1, 1),0)
	wander_time = randf_range(1, 3)


func enter():
	randomize_wander()
	player = get_tree().get_first_node_in_group("Player")
	
	if not animation_player: animation_player = AnimationPlayer.new()
	animation_player.play("RESET")


func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	if player:
		var direction = player.global_position - enemy.global_position
		sprite.flip_h = not clamp(round(direction.x), 0, 1)
		if direction.length() <= detection_distance:
			#print(direction.length())
			if attack_state:
				transition.emit(self, attack_state.name)


func physics_update(delta):
	if enemy:
		#print('wander')
		enemy.velocity.x = move_direction.x * move_speed


