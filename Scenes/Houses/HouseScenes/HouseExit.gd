extends Area2D


onready var scene = ("res://Scenes/World.tscn")
export (Vector2) var move_to_position

func _on_HouseExit1_body_entered(body):
	if body.name == "Player":
		PlayerStats.global_pos.x = PlayerStats.saved_pos.x
		PlayerStats.global_pos.y = PlayerStats.saved_pos.y
		get_tree().change_scene(scene)
