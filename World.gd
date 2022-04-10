extends Node2D

var PlayerNode
var pos_x = 30
var pos_y = 130

func _ready():
	PlayerNode = get_node("Player").get_child(0)
	if PlayerStats.player_position_x and PlayerStats.player_position_y:
		pos_x = PlayerStats.player_position_x
		pos_y = PlayerStats.player_position_y
		print("playerNode", PlayerNode.global_position)
	PlayerNode.global_position.x = pos_x
	PlayerNode.global_position.y = pos_y

func save_scene():
	var file_path = "res://World.tscn"
	var scene = PackedScene.new()
	scene.pack(World)
	ResourceSaver.save(file_path,scene)
#https://godotengine.org/qa/89982/how-to-save-changes-when-switching-scenes
