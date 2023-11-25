@tool
extends Control

@onready var main = $"../../PauseComponent"
@onready var tab_container = $TabContainer

func _ready():
	$TabContainer/Menu/MarginContainer/VBoxContainer/Resume.grab_focus()

func _on_resume_pressed():
	main.pausemenu()


func _on_quit_pressed():
	get_tree().quit()


func _on_visibility_changed():
	if self.visible:
		tab_container.current_tab = 0


func _on_settings_pressed():
	tab_container.current_tab = 1


func _on_button_pressed():
	MusicManager.play_song(MusicManager.GAME)


func _on_main_menu_pressed():
	self.hide()
	get_tree().paused = false
	LevelManager.change_scene(load("res://Worlds/level_select.tscn"))
