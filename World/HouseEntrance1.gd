extends Area2D


var scene = preload("res://HouseScenes/House1.tscn")
onready var Player = get_node("../Player/Player")


func _on_HouseEntrance1_body_entered(body):
	if body.name == "Player":
		PlayerStats.global_pos.x = position.x
		PlayerStats.global_pos.y = position.y - 20
		get_tree().change_scene_to(scene)
