class_name GoblinMovingToTaskState extends GoblinWorkingState


func EnterState():
	#ourBody.animated_sprite_2d.self_modulate = Color.AQUAMARINE
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.9,1.0)
	ourBody.navigation_agent_2d.avoidance_enabled = false
	ourBody.navigation_agent_2d.target_desired_distance = 2.0


func CanTakeNewPosition() -> bool:
	return false
