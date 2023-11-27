extends Node
class_name SnakeComponent
#  Controlls the visual body of the snake
#  Does not influence movement

@export var player: CharacterBody2D
@export var texture: Texture
@export var segments: int
@export_range(0, 10, 0.1) var spacing: float
@export var taper: Curve  # Scales the body along the curve
@export var curve: Curve  # Skews the body along the curve
@export var magnitude: float  # How much the curve gitinfluences the skew
@export var amplitude = 1.5
@export var frequency = 0.008

@onready var weapon: Node2D = $"../Weapon"

var bodies: Array[Sprite2D]		# Stores individual segment objects
var points: Array[Vector2]		# Saves previous positions
var line = Line2D.new()
var outline = Line2D.new()

var gradient = Gradient.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	gradient.add_point(0, Color(Color.RED))
	gradient.add_point(1, Color(Color.GREEN))
	
	# Creates the line used for the body
	line.width_curve = taper
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	line.width = 5
	
	#line.gradient = gradient
	
	outline.width_curve = taper
	outline.joint_mode = Line2D.LINE_JOINT_ROUND
	outline.begin_cap_mode = Line2D.LINE_CAP_ROUND
	outline.end_cap_mode = Line2D.LINE_CAP_ROUND
	outline.width = 8
	outline.default_color = Color("#000000")
	
	self.add_child(outline)
	self.add_child(line)
	
	# Adds segment objects
	for i in range(segments):
		var new_segment = Sprite2D.new()
		new_segment.top_level = true
		new_segment.global_position = player.global_position
		bodies.append(new_segment)
		new_segment.scale *= taper.sample(float(i)/float(segments))
		self.add_child(new_segment)
		line.add_point(Vector2.ZERO)
		outline.add_point(Vector2.ZERO)
	
	# Fills the points array
	for i in range(segments * spacing):
		points.push_front(player.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	points.push_front(player.global_position)
	
	# Manages points array overflow
	if points.size() > segments * spacing:
		points.remove_at(points.size()-1)
	
	var time = Time.get_ticks_msec()
	# Calculate the scale factor using the sine function
	
	# Sets segment object positions
	for i in range(segments):
		var phase_offset = i * 100
		var scale_factor = sin((time - phase_offset) * frequency) * amplitude
		bodies[i].global_position = points[i * spacing]  # Sets global position, offset by spacing
		bodies[i].position.x += curve.sample_baked(float(i)/float(segments)) * magnitude # Skews segments along x axis
		if abs(player.velocity.y) > 0:
			bodies[i].position.x += scale_factor * clamp(i, 0, 1)
		line.set_point_position(i,bodies[i].global_position)
		outline.set_point_position(i,bodies[i].global_position)
	
	if weapon:
		weapon.global_position = bodies[-1].global_position
	
