extends Area2D


var scene = preload("res://HouseScenes/House1.tscn")

func _on_HouseEntrance1_body_entered(body):
	if body.name == "Player":
		print("area entered")
		get_tree().change_scene_to(scene)
