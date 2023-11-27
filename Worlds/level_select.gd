@tool
extends Control

@onready var label = $Label
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer
@onready var levels = $ScrollContainer/MarginContainer/Levels

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")
@onready var lock: Texture = preload("res://Assets/lock.png")
@onready var pause_menu = $PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready():

	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", Vector2(24,16+5), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(label, "position", Vector2(24,16-5), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	
	MusicManager.play_song(MusicManager.GAME)

	$ScrollContainer/MarginContainer/Levels/Courtyard.grab_focus()
	$ScrollContainer.scroll_vertical = 100

#func _input(event):
#	if Input.is_action_just_pressed("pause"):
#		pause_menu.tab_container = 1
#		pause_menu.show()


func _process(delta):
	for level in range(levels.get_child_count()):
		var btn = levels.get_children()[-level-1]
		if save_data.floors[level] == false:
			btn.icon = lock
			btn.disabled = true
		else:
			btn.icon = null
			btn.disabled = false
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	parallax_layer.motion_offset += Vector2(0.2,0.2)
