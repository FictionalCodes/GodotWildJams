class_name BlobStateMachine extends StateMachine

func _init(blob:BlobBody) -> void:
	stateList[Constants.BlobState.Free] = BlobFreeState.new(blob, Constants.BlobState.Free)
	stateList[Constants.BlobState.PickedUp] = BlobHeldState.new(blob, Constants.BlobState.PickedUp)
	stateList[Constants.BlobState.Placed] = BlobBaseState.new(blob, Constants.BlobState.Placed)
	stateList[Constants.BlobState.Dead] = BlobDeadState.new(blob, Constants.BlobState.Dead)

func CanBePickedUp() -> bool:
	return currentState != null and currentState.CanBePickedUp()
