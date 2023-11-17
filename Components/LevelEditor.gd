extends TileMap
class_name LevelEditor

@export var world: Node2D

@onready var entities = {
	2: preload("res://Enemies/MeleeBear.tscn"),
	3: preload("res://Enemies/ranged_enemy.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in self.get_used_cells(1):
		var id = self.get_cell_source_id(1, cell)
		var new_entity: CharacterBody2D = entities[id].instantiate()
		new_entity.global_position = cell * 16
		print(cell * 16)
		
		self.erase_cell(1, cell)
		self.add_child(new_entity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
