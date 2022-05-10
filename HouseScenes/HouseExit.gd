extends Area2D


onready var scene = ("res://World.tscn")
export (Vector2) var move_to_position

func _on_HouseExit1_body_entered(body):
	if body.name == "Player":
		PlayerStats.global_pos.x = position.x + 30
		PlayerStats.global_pos.y = position.y + 10
		get_tree().change_scene(scene)
