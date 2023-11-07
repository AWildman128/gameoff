extends Node
class_name SnakeComponent

@export var player: CharacterBody2D
@export var texture: Texture
@export var segments: int
@export_range(0, 1, 0.1) var spacing: float
@export var taper: Curve
@export var curve: Curve
@export var magnitude: float

var bodies: Array[Sprite2D]
var points: Array[Vector2]


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(segments):
		var new_segment = Sprite2D.new()
		new_segment.texture = texture
		new_segment.top_level = true
		new_segment.global_position = player.global_position
		bodies.push_front(new_segment)
		new_segment.scale *= taper.sample(float(i)/float(segments))
		self.add_child(new_segment)
	
	for i in range(segments * spacing):
		points.push_front(player.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if player.global_position != points[0]:
	points.push_front(player.global_position)
	#print(points[0])
	
	if points.size() > segments * spacing:
		points.remove_at(points.size()-1)
	
	for i in range(segments):
		bodies[i].global_position = points[i * spacing]
		bodies[i].position.x += curve.sample_baked(float(i)/float(segments)) * magnitude
		#bodies[i].position.y += curve.sample_baked(float(i)/float(segments)) * magnitude
	
