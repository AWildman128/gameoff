extends CharacterBody2D


func _ready():
	$CanvasLayer/Control/ColorRect.show()
	$UI/TextureRect.show()
	$UI/TextureRect/Label.show()
