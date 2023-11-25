@tool
extends Control

@onready var label = $Label
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer
@onready var levels = $Levels

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")
@onready var lock: Texture = preload("res://Assets/lock.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", Vector2(24,16+5), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, "position", Vector2(24,16-5), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	
	MusicManager.play_song(MusicManager.GAME)


func _process(delta):
	for level in range(levels.get_child_count()):
		print(save_data.floors[level])
		if save_data.floors[level] == false:
			var btn = levels.get_children()[-level-1]
			btn.icon = lock
			btn.disabled = true
		else:
			levels.get_child(level).icon = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	parallax_layer.motion_offset += Vector2(0.2,0.2)
