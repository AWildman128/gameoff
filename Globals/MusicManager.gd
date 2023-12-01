extends Node

@onready var music_player = AudioStreamPlayer.new()
@onready var save_data = preload("res://Globals/SaveData.tres")

enum {
	MAIN_MENU,
	LEVEL_SELECT,
	GAME,
	CREDITS,
	TEST
}

var Volume = {
	"Master" : 100,
	"Music" : 100,
	"Sound" : 100
}


var songs = {
	GAME: preload("res://Assets/Music/Snake_Attack_6e-loop_2.mp3"),
	MAIN_MENU: preload("res://Assets/Music/Main_Menu_2c.mp3"),
	CREDITS: preload("res://Assets/Music/Snake_Den-Credits_2a.mp3"),
	TEST: preload("res://Assets/Music/001.mp3")
}


func _ready():
	music_player.bus = "Music"
	music_player.connect("finished", music_finished)
	add_child(music_player)
	print(AudioServer.get_bus_index("Master"))


func _process(delta):
	AudioServer.set_bus_volume_db(0, save_data.master)
	AudioServer.set_bus_volume_db(1, save_data.music)
	AudioServer.set_bus_volume_db(2, save_data.sound)


func play_song(song: int):
	if not songs[song]: print('Song not found in enum or Dictionary.'); return
	if songs[song] == music_player.stream: return
	
	music_player.stop()
	music_player.stream = songs[song]
	music_player.play()


func stop():
	var tween = music_player.create_tween()
	tween.tween_property(music_player, "volume_db", -100, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(music_player.stop)
	tween.tween_property(music_player, "volume_db", 0, 0)


func music_finished(song):
	print('song finished')
	music_player.play()
