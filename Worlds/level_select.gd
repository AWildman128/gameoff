extends Control

@onready var label = $Label
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", Vector2(24,16+5), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, "position", Vector2(24,16-5), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	
	MusicManager.play_song(MusicManager.GAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	parallax_layer.motion_offset += Vector2(0.2,0.2)
