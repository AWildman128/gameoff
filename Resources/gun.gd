extends Resource
class_name Gun

@export var texture: Texture2D
@export var full_auto: bool
@export var rpm: int
@export_range(0,1,0.1) var spread: float
@export var ammo: int
