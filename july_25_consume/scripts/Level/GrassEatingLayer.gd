class_name GrassEatingLayer
extends TileMapLayer

var tile_size = tile_set.tile_size

@export var eatingLayer : TileMapLayer
@export var terrainLayer : TileMapLayer

var eatableCells : Dictionary[Vector2i, EdibleTile]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func register_edible(item: EdibleTile) -> void:
	var tileCoords = local_to_map(item.position)
	eatableCells[tileCoords] = item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _init() -> void:
	pass
	
	
func get_area_camera_size() -> Rect2i:
	var usedRect = get_used_rect()
	usedRect.position *= tile_size
	usedRect.size *= tile_size
	return usedRect 
	
func _on_player_player_cell_reached(playerPos: Vector2) -> void:
	var cellCoord := local_to_map(playerPos)
	var item : EdibleTile = eatableCells.get(cellCoord)
	if item == null: return
	item.eat_it()
