extends Area2D


var scene = preload("res://HouseScenes/House3.tscn")
onready var Player = get_node("../Player/Player")

func _on_HouseEntrance3_body_entered(body):
	#when the player touches the collision area, they are transported to the 3rd house
	if body.name == "Player":
		PlayerStats.global_pos.x = position.x
		PlayerStats.global_pos.y = position.y - 20
		get_tree().change_scene_to(scene)
