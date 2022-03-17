extends Area2D


onready var scene = get_node("res://World.tscn")
export (Vector2) var move_to_position

func _on_HouseExit2_body_entered(body):
	if body.name == "Player":
		print("area entered")
		get_tree().change_scene_to(scene)
