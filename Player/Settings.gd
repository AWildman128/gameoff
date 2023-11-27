extends Control

@onready var tab = $".."
@onready var master_slider = %MasterSlider
@onready var music_slider = %MusicSlider
@onready var sound_slider = %SoundSlider


@onready var save_data = preload("res://Globals/SaveData.tres")

func _ready():
	master_slider.value = db_to_linear(save_data.master)
	music_slider.value = db_to_linear(save_data.music)
	sound_slider.value = db_to_linear(save_data.sound)
	$ScrollContainer/MarginContainer/VBoxContainer/CheckButton.grab_focus()
	$ScrollContainer/MarginContainer/VBoxContainer/CheckButton.button_pressed = save_data.fullscreen

func _process(delta):
	save_data.master = linear_to_db(master_slider.value)
	save_data.music = linear_to_db(music_slider.value)
	save_data.sound = linear_to_db(sound_slider.value)
	


func _on_check_button_toggled(button_pressed):
	if not button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		save_data.fullscreen = false
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		save_data.fullscreen = true


func _on_back_pressed():
	tab.current_tab = 0
	$"../..".focus()
