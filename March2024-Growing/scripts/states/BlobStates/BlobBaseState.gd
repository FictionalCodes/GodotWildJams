class_name BlobBaseState extends BaseState

var ourBody : BlobBody
var state : int

func _init(blob: BlobBody, stateNum:Constants.BlobState) -> void:
	ourBody = blob
	state = stateNum

func CanBePickedUp() -> bool:
	return false

func CanBeAttachedTo() -> bool:
	return false
