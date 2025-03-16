class_name BlobInputController extends Area2D

var pickedUp: FreeBlob = null
@export var blobCreate : PackedScene

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var selected := doPointQuery(event.global_position)
			if selected != null and selected is FreeBlob:
				var blob = selected as FreeBlob
				blob.pickup()
				pickedUp = blob
		elif pickedUp != null:
			pickedUp.drop()
			pickedUp = null
			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var created = blobCreate.instantiate() as FreeBlob
		created.global_position = get_global_mouse_position()
		get_parent().add_child(created)


func _physics_process(delta: float) -> void:
	if pickedUp == null:
		return
	


func doPointQuery(mousePos: Vector2) -> CollisionObject2D:
	var worldSpace = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mousePos
	query.collision_mask = 2
	query.collide_with_bodies = true
	query.collide_with_areas = false
	
	var results = worldSpace.intersect_point(query,1);

	if results.is_empty():
		return null
	var found = results.front()
	return found.collider if found != null else null
