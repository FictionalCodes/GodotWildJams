class_name Player extends Area2D

@onready var animationTree: PlayerAnimator = $AnimationTree
@onready var stateMachine: PlayerStateMachine = $PlayerStateMachine
@export var speedFactor: float = 3.0
@export var grassLayer: TileMapLayer

signal player_cell_reached(position : Vector2)

var _currentMoveDir := Vector2i.ZERO
var _inputDir := Vector2i.ZERO

var _nextCellDestination := Vector2i.ZERO
var _previousCellOrigin := Vector2i.ZERO

var _previousGlobalPos := Vector2.ZERO
var _nextGlobalPos := Vector2.ZERO

var cellMoveProgress := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_previousCellOrigin = grassLayer.local_to_map(global_position)
	_nextCellDestination = _previousCellOrigin
	position = grassLayer.map_to_local(_previousCellOrigin)
	_previousGlobalPos = position
	_nextGlobalPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var inputTemp = Input.get_vector(&"left", &"right", &"up", &"down")
	if inputTemp != Vector2.ZERO:
		if inputTemp.abs().max_axis_index() == Vector2.Axis.AXIS_X:
			inputTemp.y = 0.0
		else:
			inputTemp.x = 0.0
		_inputDir = inputTemp.sign()
		
	if _currentMoveDir != Vector2i.ZERO:
		cellMoveProgress += delta * speedFactor
		if cellMoveProgress > 1.0:
			player_cell_reached.emit(position)
			set_next_target(_inputDir)

		position = _previousGlobalPos.lerp(_nextGlobalPos, cellMoveProgress)
		
	if _currentMoveDir == Vector2i.ZERO:
		set_next_target(_inputDir)

				
func set_next_target(inputDirection: Vector2i) -> void:
	_currentMoveDir = inputDirection
	_previousCellOrigin = _nextCellDestination
	_previousGlobalPos = _nextGlobalPos
	_nextCellDestination += inputDirection
	_nextGlobalPos = grassLayer.map_to_local(_nextCellDestination)
	cellMoveProgress = 0.0
