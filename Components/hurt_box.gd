extends Area2D

@export var health_component: HealthComponent
@export var animation_player: AnimationPlayer

signal hit


func _on_area_entered(area):
	if health_component:
		health_component.set_health(-1)
		emit_signal("hit")
		var new_effect = GPUParticles2D.new()
		new_effect.lifetime = 0.5
		new_effect.one_shot = true
		new_effect.explosiveness = 1
		new_effect.process_material = load("res://Effects/hit_effect.tres")
		new_effect.emitting = true
		new_effect.z_index = 2
		self.add_child(new_effect)
		
		if animation_player:
			animation_player.stop()
			animation_player.play("Hit")
