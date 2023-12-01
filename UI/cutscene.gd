extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VideoStreamPlayer.play()
	get_tree().root.content_scale_mode = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://Worlds/main_menu.tscn")


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://Worlds/main_menu.tscn")
