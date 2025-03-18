class_name BlobBody extends RigidBody2D


var nextPos := Vector2.ZERO 

var stateMachine : BlobStateMachine

@export var initialState : Constants.BlobState = Constants.BlobState.Free

@export var minAttach := 2
@export var maxAttach := 4

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


func GetClosestConnectorPreview(connecting: Array[BlobBody]) -> Array[BlobBody]:
	var results = connecting.filter(DistanceCheck).filter(CheckCast)
	results.sort_custom(FindClosest)
	return results.

func FindClosest(a: BlobBody, b: BlobBody) -> bool:
	var distanceA = global_position.distance_to(a.global_position)
	var distanceB = global_position.distance_to(b.global_position)
	return distanceA < distanceB
	
func CheckCast(item: BlobBody) -> bool:
	pass
	
func DistanceCheck(item: BlobBody) -> bool:
	pass
