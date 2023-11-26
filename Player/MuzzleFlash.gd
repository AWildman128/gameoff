extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.emitting = true
	await get_tree().create_timer(0.2).timeout
	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
