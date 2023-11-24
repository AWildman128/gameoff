extends Node

@onready var music_player = AudioStreamPlayer.new()

enum {
	MAIN_MENU,
	LEVEL_SELECT,
	GAME
}

var songs = {
	GAME: ''
}


func _ready():
	add_child(music_player)


func play_song(song: int):
	if not song in range(0, len(songs.values())): print("Song not found in ENUM."); return
	
	music_player.stop()
	music_player.stream = song
	music_player.play()
