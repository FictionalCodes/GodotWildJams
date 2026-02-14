class_name TileMapConsts


const eatable_data_layer_index := 0 
const eatable_data_layer_name := &"Eatable"


func get_eatable_tilemap_coords(atlas: TileSetAtlasSource) -> Array[TileMapCoords]:
	# the fact im putting comments here shows you its a bit weird
	# YES the godot docs DO say to do exactly this
	# https://docs.godotengine.org/en/stable/classes/class_tilesetsource.html
	
	var results :Array[TileMapCoords]
	
	# first grab the count of the tiles in the atlas
	for i: int in atlas.get_tiles_count():
		# because everything in the atlas does things based on coords
		# we get the coords based on the Index of the tile
		var atlasPos := atlas.get_tile_id(i)
		
		# then we grab every possible alternative, which there will always be 1 (0)
		# then we iterate over that count and THEN get the tiledata
		for alt: int in atlas.get_alternative_tiles_count(atlasPos):
			var tileData = atlas.get_tile_data(atlasPos, alt)
			
			# finally, check if our eatable datalayer is on it
			# if yes, then check if its true
			if tileData.has_custom_data(eatable_data_layer_name) and tileData.get_custom_data(eatable_data_layer_name):
				#put the data into that helpler struct and then add it to the array
				results.push_back(TileMapCoords.new(atlasPos, alt))
				
	return results
			
# mini data class for my goddamn sanity
class TileMapCoords extends RefCounted:
	var position: Vector2i
	var altIndex: int
	
	func _init(p: Vector2i, a: int) -> void:
		position = p
		altIndex = a
