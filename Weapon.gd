@tool
extends Node2D

const aimSpeed = 10
@export var data: Gun : set = set_data
@onready var weapon_sprite = $WeaponSprite
@onready var hurtbox_component = $HurtboxComponent


func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(weapon_sprite, "position", Vector2(0,-8), 1).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(weapon_sprite, 'position', Vector2(0,-4), 1).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()


func _process(delta):
	weapon_sprite.texture = data.texture


func set_data(new_data: Gun = null):
	data = new_data


func _on_hurtbox_component_body_entered(body):
	body.get_node("Weapon").data = data
