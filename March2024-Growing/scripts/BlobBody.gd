class_name BlobBody extends RigidBody2D

var nextPos := Vector2.ZERO 

var stateMachine : BlobStateMachine

@export var initialState : Constants.BlobState = Constants.BlobState.Free

func _init() -> void:
	stateMachine = BlobStateMachine.new(self)

func _ready() -> void:
	stateMachine.QueueSwapState(initialState)

func _physics_process(delta: float) -> void:
	stateMachine.Update(delta)

func pickup() -> void:
	stateMachine.QueueSwapState(Constants.BlobState.PickedUp)

func drop(impulse=Vector2.ZERO):
	stateMachine.QueueSwapState(Constants.BlobState.Free)
	apply_central_impulse(impulse)

func CanBePickedUp() -> bool:
	return stateMachine.CanBePickedUp()
