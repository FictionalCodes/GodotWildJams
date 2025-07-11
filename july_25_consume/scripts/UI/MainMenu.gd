class_name MainMenu
extends Control

@export var firstScene:PackedScene
@export var clickAudioPlayer:AudioStreamPlayer
func StartGame():
	clickAudioPlayer.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(firstScene)
