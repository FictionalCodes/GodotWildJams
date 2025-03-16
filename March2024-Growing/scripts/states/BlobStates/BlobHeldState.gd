class_name BlobHeldState extends BlobBaseState

func Update(delta: float) -> int:
	ourBody.global_transform.origin = ourBody.get_global_mouse_position()
	
	return state

func EnterState() -> void:
	ourBody.freeze = true

func ExitState() -> void:
	ourBody.freeze = false
