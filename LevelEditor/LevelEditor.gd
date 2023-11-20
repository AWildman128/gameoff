@tool
extends TileMap
class_name LevelEditor

#@export var world: Node2D
@export var objects: Array[ObjectData] = []

const OBJECT_LAYER = 2

func _enter_tree():
	self.tile_set = load("res://LevelEditor/level_editor.tres")
	self.add_layer(1)
	self.set_layer_name(0, "Terrain")
	self.set_layer_name(1, "Objects")
	
	for layer in range(self.get_layers_count()-1):
		if not self.get_layer_name(layer):
			remove_layer(layer)


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint(): return
	
	for cell in self.get_used_cells(OBJECT_LAYER):  # Returns contents of layer 1
		var tile: TileData = get_cell_tile_data(OBJECT_LAYER, cell)
		
		for object in objects:
			if object.cell == self.get_cell_atlas_coords(OBJECT_LAYER, cell):
				var new_entity = object.scene.instantiate()
				new_entity.global_position = Vector2(cell.x * 16 + 8, cell.y * 16 + 8)

				self.erase_cell(OBJECT_LAYER, cell)
				self.add_child(new_entity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
