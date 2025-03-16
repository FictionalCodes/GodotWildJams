class_name StateMachine extends RefCounted

var stateList: Dictionary[int, BaseState]

var currentState = null
var currentStateIndex = 0

var CurrentStateIndex: int:
	get:
		return currentStateIndex
	set(value):
		QueueSwapState(value)

func QueueSwapState(newStateKey:int):
	if(newStateKey == currentStateIndex || newStateKey == 0):
		return
	var newState = stateList.get(newStateKey)
	if newState == currentState:
		return

	if newState == null:
		printerr("Trying to get a state that doesnt exist")
		return

	call_deferred("SwapStateImmediate", newState)
	currentStateIndex = newStateKey

func SwapStateImmediate(newState) -> void:
	if currentState != null: currentState.ExitState()
	newState.EnterState()
	currentState = newState

func Update(delta: float) -> void:
	if currentState == null: return
	var updatedState = currentState.Update(delta)
	if updatedState != null and updatedState != 0:
		QueueSwapState(updatedState)
