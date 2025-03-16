class_name FreeBlob extends RigidBody2D

const BlobMaskValue := 2

var held := false
var nextPos := Vector2.ZERO 


func _physics_process(delta: float) -> void:
	if held:
		global_transform.origin = get_global_mouse_position()
		
func pickup() -> void:
	if held:
		return
	freeze = true
	held = true

func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
