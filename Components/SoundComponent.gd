extends Node
class_name SoundComponent

@export var sounds: Array[SoundData]

var sound_list: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready():
	for sound in sounds:
		sound_list[sound.name] = sound.sound


func play(sound: String):
	print("Playing sound " + sound)
	var new_sound_player = AudioStreamPlayer2D.new()
	new_sound_player.stream = sound_list[sound]
	new_sound_player.bus = "Sound"
	new_sound_player.pitch_scale = randf_range(0.9,1)
	self.add_child(new_sound_player)
	new_sound_player.play()
	await get_tree().create_timer(10).timeout
	self.remove_child(new_sound_player)
