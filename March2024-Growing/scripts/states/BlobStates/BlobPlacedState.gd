class_name BlobPlacedState extends BlobBaseState

func EnterState():
	ourBody.freeze = false

func Update(delta: float):
	pass

func CanBePickedUp() -> bool:
	return false
	
func CanBeAttachedTo() -> bool:
	return true
