extends Node

@export var area: Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not area: area = Area2D.new()
	area.connect("area_entered", on_area_entered)


func on_area_entered(area):
	print(area)

