extends Control

@onready var master_slider = %MasterSlider
@onready var music_slider = %MusicSlider
@onready var sound_slider = %SoundSlider


@onready var save_data = preload("res://Globals/SaveData.tres")

func _ready():
	master_slider.value = db_to_linear(save_data.master)
	music_slider.value = db_to_linear(save_data.music)
	sound_slider.value = db_to_linear(save_data.sound)


func _process(delta):
	save_data.master = linear_to_db(master_slider.value)
	save_data.music = linear_to_db(music_slider.value)
	save_data.sound = linear_to_db(sound_slider.value)
	
