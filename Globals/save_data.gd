extends Resource
class_name SaveData

@export_category("Save Data")
@export_group("Player")
@export_subgroup("Unlocks")
@export var floors: Array[bool]

@export_group("Settings")
@export_subgroup("Video")
@export var fullscreen: bool

@export_subgroup("Audio")
@export var master = 1
@export var music = 1
@export var sound = 1
