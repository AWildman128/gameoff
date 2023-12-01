extends Control

@export var world: PackedScene
@onready var tab_container = $TabContainer

func _ready():
	get_tree().root.content_scale_mode = 1
	$TabContainer.current_tab = 0
	$TabContainer/Menu/MarginContainer/VBoxContainer/Start.grab_focus()
	MusicManager.play_song(MusicManager.MAIN_MENU)


func _on_start_pressed():
	LevelManager.change_scene(load("res://Worlds/level_select.tscn"))


func _on_settings_pressed():
	tab_container.current_tab = 1


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		tab_container.current_tab = 0


func _on_quit_pressed():
	get_tree().quit()


func focus():
		$TabContainer/Menu/MarginContainer/VBoxContainer/Start.grab_focus()


func _exit_tree():
	get_tree().root.content_scale_mode = 2
