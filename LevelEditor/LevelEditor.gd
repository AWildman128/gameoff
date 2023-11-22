@tool
extends TileMap
class_name LevelEditor

@export var objects: Array[ObjectData] = []

const OBJECT_LAYER: int = 0


# Called when the node and it's children enters the scene tree for the first time.
func _ready():# Called when the node enters the scene tree for the first time.
	if Engine.is_editor_hint():
		print("Created New Level")
		#  This updates 
		self.tile_set = load("res://LevelEditor/level_editor.tres")
		self.set_layer_name(0, "Level")
		
	if Engine.is_editor_hint(): return
	
	for cell in self.get_used_cells(OBJECT_LAYER):  # Returns contents of layer 1
		for object in objects:
			if object.cell == self.get_cell_atlas_coords(OBJECT_LAYER, cell):
				var new_entity: CharacterBody2D = object.scene.instantiate()
				new_entity.global_position = Vector2(cell.x * 16 + 8, cell.y * 16 + 8)

				self.erase_cell(OBJECT_LAYER, cell)
				self.add_child(new_entity)
