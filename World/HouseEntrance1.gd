extends Area2D


var scene = preload("res://HouseScenes/House1.tscn")
onready var Player = get_node("../Player/Player")

func _on_HouseEntrance1_body_entered(body):
	if body.name == "Player":
		Player.position = position
		print("entering position", Player.position)
		get_tree().change_scene_to(scene)
