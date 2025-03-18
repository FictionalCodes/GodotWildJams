class_name BlobPlacedState extends BlobBaseState

func EnterState():
	ourBody.freeze = false
	ourBody.set_collision_layer_value(Constants.STRUCTURE_BLOB_LAYER_INDEX, true)

func ExitState():
	ourBody.set_collision_layer_value(Constants.STRUCTURE_BLOB_LAYER_INDEX, false)

func Update(delta: float):
	pass

func CanBePickedUp() -> bool:
	return false
	
func CanBeAttachedTo() -> bool:
	return true
