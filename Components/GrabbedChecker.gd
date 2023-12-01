extends State
class_name GrabbedChecker

@export var area: Area2D


func enter():
	if not area: area = Area2D.new()
	area.connect("area_entered", on_area_entered)
	#print(area.get_signal_connection_list("area_entered"))


func on_area_entered(area):
	print('area entered')
	if area.is_in_group("Player"):
		get_parent().transition.emit(self.get_parent(), "grabbedstate")
