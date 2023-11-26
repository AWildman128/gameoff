extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var muzzle_flash = preload("res://Materials/hit_particles.tscn")
@onready var snake_component = $SnakeComponent


var direction = Vector2.LEFT
var life_time: float = 1
var hit_something = false

func _ready():
	velocity = -direction * 400
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color(1,1,1,0), life_time).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(life_time).timeout
	self.queue_free()
	

func _physics_process(delta):
	move_and_slide()
	
	if is_on_wall() and not hit_something:
		hit_something = true
		velocity = Vector2.ZERO
		$Area2D.monitorable = false
		$Area2D.monitoring = false
		var new_flash = muzzle_flash.instantiate()
		new_flash.look_at(get_wall_normal())
		new_flash.emitting = true
		self.add_child(new_flash)
		snake_component.queue_free()
		await get_tree().create_timer(1).timeout
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy") and not self.is_in_group("Enemy"):
		area.hit(-1)
		self.queue_free()
	elif area.is_in_group("Player") and self.is_in_group("Enemy"):
		area.hit(-1)

