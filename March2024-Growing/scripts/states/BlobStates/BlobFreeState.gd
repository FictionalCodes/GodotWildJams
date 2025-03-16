class_name BlobFreeState extends BlobBaseState

func EnterState():
	ourBody.freeze = false

func Update(delta: float):
	pass

func CanBePickedUp() -> bool:
	return true
