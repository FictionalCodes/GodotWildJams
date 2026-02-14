class_name EdibleTile
extends Sprite2D

@export var possibleTextures: Array[Texture2D]
@export var possibleEatenTextures : Array[Texture2D]

@export var score : int

@onready var particles := $CPUParticles2D

var eaten: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = possibleTextures.pick_random()
	get_parent().register_edible(self)


func eat_it(setTexture: Texture2D = null) -> void:
	if eaten : return
	if setTexture != null:texture = setTexture
	elif !possibleEatenTextures.is_empty(): texture = possibleEatenTextures.pick_random() 
	else: texture = null
	
	particles.emitting = true
	eaten = true


func _on_cpu_particles_2d_finished() -> void:
	if texture == null:
		queue_free()
