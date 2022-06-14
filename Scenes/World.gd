extends Node2D

var thief = preload("res://Enemies/Thief/Thief.tscn").instance()
var player = preload("res://Player/Player.tscn").instance()
var executioner = preload("res://Enemies/Executioner/Executioner.tscn").instance()

func _ready():
	$Player/Player.global_position = PlayerStats.global_pos

#func save_scene():
#	var file_path = "res://World.tscn"
#	var scene = PackedScene.new()
#	scene.pack(World)
#	ResourceSaver.save(file_path,scene)

func from_dictionary(data):
	player.global_position = Vector2(data.player.position[0], data.player.position[1])
	PlayerStats.global_pos = $Player/Player.global_position
	PlayerStats.health = data.player.health
	PlayerStats.armor = data.player.armor
	player.fireball_given = data.player.fireball_given
	
	for thief_data in data.thieves:
		thief.from_dictionary(thief_data)
		$ForestSpawnArea.add_child(thief)

	executioner.global_position = Vector2(data.executioner.position[0], data.executioner.position[1])
