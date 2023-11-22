extends Node2D


@export var data: Gun : set = set_data
@onready var sprite = $Sprite2D

@onready var bullet = preload("res://Entities/Bullet.tscn")
@onready var muzzle_flash = preload("res://Entities/MuzzleFlash.tscn")
@onready var player = $".."
@onready var rpm_timer = $RPMTimer
@onready var muzzle = $Muzzle


var ammo = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if data:
		set_data(data)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not data: sprite.texture = null; return
	sprite.texture = data.texture
	
	self.look_at(get_global_mouse_position())
	if self.rotation_degrees > 360 or self.rotation_degrees < -360:
		self.rotation_degrees = 0
	
	if abs(self.rotation_degrees) > 90 and abs(self.rotation_degrees) < 270:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	
	if data.full_auto:
		if Input.is_action_pressed("r_click") and rpm_timer.time_left == 0:
			shoot()
	else:
		if Input.is_action_just_pressed("r_click") and rpm_timer.time_left == 0:
			shoot()


func shoot():
	var direction = (player.global_position - get_global_mouse_position())
	direction.normalized()
	
	print(data.rpm)
	print(60/data.rpm)
	rpm_timer.stop()
	rpm_timer.start(60/data.rpm)
	print(rpm_timer.time_left)
	
	for i in range(data.bullets):
		var new_bullet = bullet.instantiate()
		new_bullet.top_level = true
		new_bullet.life_time = data.life_time
		new_bullet.global_position = muzzle.global_position
		new_bullet.velocity += self.get_parent().velocity
		new_bullet.direction = spread_vector(direction, data.spread)
		muzzle.add_child(new_bullet)
	
	var new_flash = muzzle_flash.instantiate()
	new_flash.position.x += 10
	self.add_child(new_flash)
	
	player.velocity = Vector2.ZERO
	player.velocity = Vector2(direction.x*data.recoil/2, direction.y*data.recoil)
	if player.is_on_wall():
		player.velocity.x += player.get_wall_normal().x
	
	ammo -= 1
	if ammo <= 0: set_data()


func spread_vector(vector: Vector2, spread: float):
	var angle_rad = deg_to_rad(randf_range(-spread, spread)*20)
	var new_vector = Vector2(
		vector.x * cos(angle_rad) - vector.y * sin(angle_rad),
		vector.x * sin(angle_rad) + vector.y * cos(angle_rad)
	)
	return new_vector.normalized()


func set_data(new_data = null):
	data = new_data
	
	if new_data:
		if sprite:
			sprite.texture = new_data.texture
		ammo = new_data.ammo
	else:
		sprite.texture = null
		ammo = 0
