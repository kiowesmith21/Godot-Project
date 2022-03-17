extends Area2D


var scene = preload("res://HouseScenes/House3.tscn")

func _on_HouseEntrance3_body_entered(body):
	#when the player touches the collision area, they are transported to the 3rd house
	if body.name == "Player":
		body.global_position = global_position
		get_tree().change_scene_to(scene)
		
