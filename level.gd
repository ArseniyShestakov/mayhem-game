extends Node2D


signal level_clicked


func _ready():
	
	$character.level_scene = self
	$character.is_player = true
	
	$enemy.level_scene = self


func _input(event):
   if event is InputEventMouseButton:
	   emit_signal("level_clicked", event.global_position)
