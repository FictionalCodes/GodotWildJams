class_name LevelArea extends Node2D

@export var grassLayer : TileMapLayer
@export var eatingLayer : TileMapLayer
@export var terrainLayer : TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grassLayer.get_used_cells()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
