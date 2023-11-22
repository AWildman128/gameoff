extends Control

@onready var main = $"../../PauseComponent"

func _on_resume_pressed():
	main.pausemenu()


func _on_quit_pressed():
	get_tree().quit()
