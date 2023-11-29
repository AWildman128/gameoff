extends State
class_name EnemyMelee

@export var enemy: CharacterBody2D
@export var move_speed: int
@export var wander: State
@export var detection_distance = 50
@export var animation_player: AnimationPlayer
@export var attack_area: Area2D
@export var sprite: Sprite2D

var player: Node2D


func enter():
	player = get_tree().get_first_node_in_group("Player")
	
	if not animation_player: animation_player = AnimationPlayer.new()
	animation_player.animation_finished.connect(on_animation_finished)
	
	attack_area.connect("area_entered", on_attack_area_entered)
	print(attack_area.get_signal_connection_list("area_entered"))


func physics_update(delta):
	var direction = player.global_position - enemy.global_position
	
	
	if direction.length() > 12 and not animation_player.current_animation == "Attack":
		enemy.velocity.x = round(direction.normalized().x) * move_speed
		animation_player.play("Run")
		sprite.flip_h = not clamp(enemy.velocity.x, 0, 1)
	else:
		enemy.velocity.x = 0
		animation_player.play("Attack")

	if direction.normalized().x > 0:
		attack_area.rotation_degrees = 0
	elif direction.normalized().x < 0:
		attack_area.rotation_degrees = 180

	if direction.length() > detection_distance:
		transition.emit(self, wander.name)


func on_animation_finished(anim):
	if anim == "Attack":
		animation_player.stop()


func on_attack_area_entered(area):
	print('area')
	if area.is_in_group("Player"):
		area.hit(-1)
