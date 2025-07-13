class_name GrassEatingLayer
extends TileMapLayer

var tile_size = tile_set.tile_size

func _init() -> void:
	pass
	
func _ready() -> void:
	#tile_map_data
	pass
	
func get_area_camera_size() -> Rect2i:
	var usedRect = get_used_rect()
	usedRect.position *= tile_size
	usedRect.size *= tile_size
	return usedRect 
	
