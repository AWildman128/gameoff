extends Node2D

const aimSpeed = 10
@export var data: Gun
@export var hurt_box: HurtboxComponent

@onready var timer = $Timer
@onready var ray = $RayCast2D
@onready var line = $RayCast2D/Line2D
@onready var bullet = preload("res://Entities/Bullet.tscn")
@onready var rpm_timer = $RPMTimer

var shots = 3
var shot_time = .5
var range = 200
var player_in_range
var target : CharacterBody2D

signal finished_shooting


func shoot(t):
	if not data: return
	timer.start()
	target = t

func _process(delta):
#	if hurt_box: 
#		if data:
#			hurt_box.monitorable = false
#		else:
#			hurt_box.monitorable = true
			
	if not data: hide(); $Area2D.monitoring=false; return
	
	if timer.time_left > 0:
		if target != null:
			look_at(target.global_position)
			ray.target_position.x = range
			line.visible = true
			line.points[1].x = (ray.get_collision_point() - global_position).length()
		line.default_color = Color(255, timer.time_left / timer.wait_time, timer.time_left / timer.wait_time, 1 - timer.time_left / timer.wait_time)

func _on_timer_timeout():
	if not data: return
	for i in range(shots):
		fire()
		print("shoot")
		await get_tree().create_timer(60/data.rpm).timeout
	finished_shooting.emit()

func fire():
	$Sprite2D. visible = true
	await get_tree().create_timer(shot_time).timeout
	#var hit = ray.get_collider()
	$Sprite2D. visible = false
#	if not hit:
#		return
#	if hit.is_in_group("Player"):
#		hit.hit()
	
	var direction = (self.global_position - target.global_position)
	direction.normalized()
	
	#rpm_timer.start(60/data.rpm)
	var new_bullet = bullet.instantiate()
	new_bullet.add_to_group("Enemy")
	new_bullet.global_position = self.global_position
	new_bullet.top_level = true
	new_bullet.direction = direction 
	self.add_child(new_bullet)


#func _on_area_2d_area_entered(area):
#	print('penis')
#	if area.is_in_group("Bullet"):
#		data = null


func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("Player"):
		body.get_node("Weapon").data = data
		data = null
