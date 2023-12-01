extends Node2D

const aimSpeed = 10
@export var data: Gun
@export var hurt_box: HurtboxComponent

@onready var timer = $Timer
@onready var ray = $RayCast2D
@onready var line = $RayCast2D/Line2D
@onready var bullet = preload("res://Entities/Bullet.tscn")
@onready var rpm_timer = $RPMTimer
@onready var sprite = $Sprite2D2
@onready var empty = preload("res://Resources/Empty.tres")

var shots = 3
var shot_time = .5
var range = 200
var player_in_range
var target : CharacterBody2D

signal finished_shooting


func shoot(t = null):
	if not t: target = null; return
	if data.rpm == 0: return
	
	timer.start()
	target = t


func _process(delta):
	if data.ammo == 0: self.hide(); $Area2D.monitoring=false; return
	
	sprite.texture = data.texture
	
	if not target:
		line.visible = false
		return
	
	if timer.time_left > 0:
		if target != null:
			look_at(target.global_position)
			ray.target_position.x = range
			line.visible = true
			line.points[1].x = (ray.get_collision_point() - global_position).length()
		line.default_color = Color(255, 255, 255,  1 - timer.time_left / timer.wait_time)


func _on_timer_timeout():
	if data.ammo == 0: return
	line.visible = false
	for i in range(data.burst):
		fire()
		await get_tree().create_timer(60/data.rpm).timeout
	await get_tree().create_timer((60/data.rpm)*shots).timeout
	finished_shooting.emit()
	line.visible = true


func fire():
	await get_tree().create_timer(shot_time).timeout
	#var hit = ray.get_collider()
	#$Sprite2D. visible = false
	
	var direction = self.global_position.direction_to(ray.get_collision_point())
	direction = direction.normalized()
	direction = -direction
	
	#rpm_timer.start(60/data.rpm)
	for i in range(data.bullets):
		var new_bullet = bullet.instantiate()
		new_bullet.add_to_group("Enemy")
		new_bullet.global_position = self.global_position
		new_bullet.life_time = data.life_time
		new_bullet.velocity += self.get_parent().velocity
		new_bullet.direction = spread_vector(direction, data.spread)
		new_bullet.top_level = true
		self.add_child(new_bullet)


func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("Player"):
		body.get_node("Weapon").data = data
		#self.remove_child(self)
		data = load("res://Resources/Empty.tres")
		


func spread_vector(vector: Vector2, spread: float):
	var angle_rad = deg_to_rad(randf_range(-spread, spread)*20)
	var new_vector = Vector2(
		vector.x * cos(angle_rad) - vector.y * sin(angle_rad),
		vector.x * sin(angle_rad) + vector.y * cos(angle_rad)
	)
	return new_vector.normalized()
