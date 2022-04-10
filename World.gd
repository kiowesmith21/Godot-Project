extends Node2D

func _ready():
	$Player/Player.global_position = PlayerStats.global_pos
	
func save_scene():
	var file_path = "res://World.tscn"
	var scene = PackedScene.new()
	scene.pack(World)
	ResourceSaver.save(file_path,scene)
#https://godotengine.org/qa/89982/how-to-save-changes-when-switching-scenes
