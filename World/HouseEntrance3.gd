extends Area2D


var scene = preload("res://HouseScenes/House3.tscn")
onready var Player = get_node("../Player/Player")

func _on_HouseEntrance3_body_entered(body):
	#when the player touches the collision area, they are transported to the 3rd house
	if body.name == "Player":
		Player.position = position
		PlayerStats.player_position_x = position.x
		PlayerStats.player_position_y = position.y
		get_tree().change_scene_to(scene)
		
