extends Camera2D

onready var character = get_node("/root/Node2D/character")

func _process(delta):
	if !character:
		return
	position.x = character.position.x
	position.y = character.position.y
