extends Area2D


var scene = preload("res://HouseScenes/House2.tscn")

func _on_HouseEntrance2_body_entered(body):
		#when the player touches the collision area, they are transported to the 2nd house
	if body.name == "Player":
		print("area entered")
		get_tree().change_scene_to(scene)
