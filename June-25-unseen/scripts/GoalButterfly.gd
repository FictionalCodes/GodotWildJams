extends Area2D
@export var next_scene:PackedScene
@export var next_scene_timeout:float = 1
@onready var sfx_player:AudioStreamPlayer = $LevelComplete_AudioStreamPlayer
var collected = false
func _on_body_entered(body:Node2D) -> void:
	if(collected): return
	collected = true
	if body.is_in_group("player"):
									GameManager.complete_level()
									sfx_player.play()
									var timer = get_tree().create_timer(next_scene_timeout)
									timer.timeout.connect(_change_scene)
												
func _change_scene():
		print_debug("load scene") 
		get_tree().change_scene_to_packed(next_scene)
