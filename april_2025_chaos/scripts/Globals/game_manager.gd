extends Node


var player
var goblins : GoblinContainer


var current_highest_level : int = 1

func set_player(target):
	player = target
	print(player)

func set_goblins(target):
	goblins = target

func set_highest_level(level : int):
	if level > current_highest_level:
		current_highest_level = level
