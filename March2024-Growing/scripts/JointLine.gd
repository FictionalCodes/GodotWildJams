extends Line2D

var node1 : Node2D
var node2 : Node2D

func _ready() -> void:
	var joint := get_parent() as DampedSpringJoint2D
	node1 = get_node("../" + StringName(joint.node_a)) as Node2D
	node2 = get_node("../" + StringName(joint.node_b)) as Node2D

func _physics_process(delta: float) -> void:
	set_point_position(0, to_local(node1.global_position))
	set_point_position(1, to_local(node2.global_position))
