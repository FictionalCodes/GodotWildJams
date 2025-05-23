class_name Goblin extends CharacterBody2D


@export var speed : float = 60.0
@export var separation_radius : float = 55.0

@export var initialState: Constants.GoblinState = Constants.GoblinState.Idle

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var stateMachine: GoblinStateMachine
var currentWaypoint: WaypointMarker = null

var workTarget :CollectItem = null
var dropoffPoint : CollectionPoint = null
var heldItem:= false


func _ready() -> void:
	stateMachine = GoblinStateMachine.new(self, initialState)
	navigation_agent_2d.max_speed = speed
	navigation_agent_2d.radius = separation_radius
	
func _physics_process(delta: float) -> void:
	stateMachine.Update(delta)
	
func moveOnPath() -> void:
	var next_path_point = navigation_agent_2d.get_next_path_position()
	velocity = (next_path_point-global_position).normalized() * speed
	move_and_slide()
	animation_control()
	navigation_agent_2d.velocity = velocity

func on_avoid_calc(safe_Velocity : Vector2) -> void:
	#if !safe_Velocity.length_squared() < 0.1 and stateMachine.CanTakeNewPosition():
		# avoid other goblins once nav has stopped	
	animation_control()

	velocity = safe_Velocity
	move_and_slide()
	navigation_agent_2d.velocity = velocity



var last_position: Vector2
var direction = 4  # Default facing down

func animation_control():
	stateMachine.DoAnimationControl()
	
func die():
	stateMachine.QueueSwapState(Constants.GoblinState.Dead)
	get_parent().goblin_died(self)
	

func setWaypoint(waypoint:WaypointMarker):
	if currentWaypoint == waypoint:
		return
	currentWaypoint = waypoint
	var scatterTarget = Vector2(randf_range(-separation_radius, separation_radius), randf_range(-separation_radius, separation_radius))
	
	if stateMachine.CanTakeNewPosition():
		navigation_agent_2d.target_position = waypoint.global_position + scatterTarget
		stateMachine.QueueSwapState(Constants.GoblinState.Moving)


func _on_navigation_agent_2d_navigation_finished() -> void:
	if workTarget == null:
		stateMachine.QueueSwapState(Constants.GoblinState.Idle)
	else:
		startWork(workTarget)

func IsWaypointCloserThanCurrent(waypoint: WaypointMarker) -> bool:
	if currentWaypoint == null or !currentWaypoint.active:
		return true
	if waypoint == currentWaypoint:
		return false
	
	var distanceCurrent = global_position.distance_squared_to(currentWaypoint.global_position)
	var distanceNew = global_position.distance_squared_to(waypoint.global_position)
	
	return distanceNew < distanceCurrent

func CanAwaken() -> bool:
	return stateMachine.CanAwaken()

func _on_detection_area_body_entered(body: Node2D) -> void:
	stateMachine.OnDetection(body)
	
func setWorkTarget(body: CollectItem) -> void:
	workTarget = body
	body.worker = self
	navigation_agent_2d.target_position = body.global_position
	navigation_agent_2d.target_desired_distance = 5.0

func setCollectionTarget(body: CollectionPoint) -> void:
	dropoffPoint = body
	navigation_agent_2d.target_position = body.global_position
	navigation_agent_2d.target_desired_distance = 5.0
	
func dropBook() -> void:
	heldItem = false
	workTarget = null
	dropoffPoint = null
	stateMachine.QueueSwapState(Constants.GoblinState.Idle)


func startWork(body: CollectItem) -> void:
	stateMachine.QueueSwapState(Constants.GoblinState.Working)

func workCompleted() -> void:
	if workTarget != null:
		workTarget.WorkCompleted()
		workTarget = null
		heldItem = true
	


func _on_hit_box_body_entered(body: Node2D) -> void:
	die()
