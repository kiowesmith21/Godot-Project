extends Area2D


onready var scene = ("res://World.tscn")
export (Vector2) var move_to_position

func _on_HouseExit1_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(scene)
