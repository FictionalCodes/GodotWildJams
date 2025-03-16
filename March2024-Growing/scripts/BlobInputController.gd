class_name BlobInputController extends Node2D

var pickedUp: BlobBody = null
@export var blobCreate : PackedScene

@onready var selectionArea :Area2D = $BlobSelector

var hoveringBlobs : Array[BlobBody] = []

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var selected := doPointQuery(event.global_position)
			if selected != null and selected is BlobBody:
				pickupBlob(selected)
		elif pickedUp != null:
			placeBlob()
			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var created = blobCreate.instantiate() as BlobBody
		created.global_position = event.global_position
		get_parent().add_child(created)
	if event is InputEventMouseMotion and pickedUp != null:
		queue_redraw()

func pickupBlob(selected: BlobBody) -> void:
	if selected.CanBePickedUp():
		selected.pickup()
		pickedUp = selected
		selectionArea.process_mode = Node.PROCESS_MODE_INHERIT
		hoveringBlobs.clear()


func placeBlob() -> void:
	pickedUp.drop()
	pickedUp = null
	selectionArea.process_mode = Node.PROCESS_MODE_DISABLED
	hoveringBlobs.clear()


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


func on_body_entered(body: Node2D) -> void:
	print("Mouse Area Entered")

	if body is BlobBody:
		print("Structure Blob Found")
		hoveringBlobs.append(body as BlobBody)
		queue_redraw()


func on_body_exited(body: Node2D) -> void:
	print("Mouse Area Exited")

	if body is BlobBody:
		print("Structure Blob Found")
		var blob = body as BlobBody
		hoveringBlobs.erase(blob)
		queue_redraw()

func _physics_process(_delta: float) -> void:
	transform.origin = get_global_mouse_position()

func _draw() -> void:
	if pickedUp != null:
		for blob in hoveringBlobs:
			#print(pickedUp.global_position, blob.global_position)
			draw_line(to_local(pickedUp.global_position), to_local(blob.global_position), Color.RED)
