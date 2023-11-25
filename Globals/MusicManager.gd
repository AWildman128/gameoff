extends Node

@onready var music_player = AudioStreamPlayer.new()
@onready var save_data = preload("res://Globals/SaveData.tres")
enum {
	MAIN_MENU,
	LEVEL_SELECT,
	GAME
}

var Volume = {
	"Master" : 100,
	"Music" : 100,
	"Sound" : 100
}


var songs = {

}


func _ready():
	music_player.bus = "Music"
	add_child(music_player)
	print(AudioServer.get_bus_index("Master"))


func _process(delta):
	AudioServer.set_bus_volume_db(0, save_data.master)
	AudioServer.set_bus_volume_db(1, save_data.music)
	AudioServer.set_bus_volume_db(2, save_data.sound)


func play_song(song: int):
	if not songs[song]: print('Song not found in enum or Dictionary.'); return
	
	music_player.stop()
	music_player.stream = songs[song]
	music_player.play()


func _exit_tree():
	ResourceSaver.save(save_data, "res://Globals/SaveData.tres")
