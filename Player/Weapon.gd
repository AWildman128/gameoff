extends Node2D


@export var data: Gun : set = set_data
@onready var sprite = $Sprite2D

@onready var bullet = preload("res://Entities/Bullet.tscn")
@onready var player = $".."
@onready var rpm_timer = $RPMTimer

var ammo = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if data:
		sprite.texture = data.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not data: sprite.texture = null; return
	
	self.look_at(get_global_mouse_position())
	print(self.rotation_degrees)
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
		if Input.is_action_just_pressed("r_click"):
			shoot()


func shoot():
	var direction = (player.global_position - get_global_mouse_position())
	direction.normalized()
	
	rpm_timer.start(60/data.rpm)
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = self.global_position
	new_bullet.top_level = true
	new_bullet.direction = direction * (randf_range(-data.spread, data.spread)*10)
	self.add_child(new_bullet)
	ammo -= 1
	if ammo <= 0: set_data()
	
	player.velocity = Vector2(direction.x, direction.y*2)
	if player.is_on_wall():
		player.velocity.x += player.get_wall_normal().x
	

func set_data(new_data = null):
	data = new_data
	if data:
		sprite.texture = new_data.texture
		ammo = new_data.ammo
	else:
		sprite.texture = null
		ammo = 0
