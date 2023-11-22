extends Resource
class_name Gun

@export var texture: Texture2D
@export var full_auto: bool
@export_range(0,10,1) var bullets: int
@export_range(0,1000,1) var rpm: float
@export_range(0,1,0.1) var spread: float
@export_range(0,10,0.1) var recoil: float
@export_range(0,1,0.1) var life_time: float
@export var ammo: int
