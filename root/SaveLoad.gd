extends Node

var load_saved_game = false

var world

var player = preload("res://Player/Player.gd")
var ForestSpawnArea = preload("res://Scenes/Areas/Forest-Spawn-Area.gd")
var executioner = preload("res://Enemies/Executioner/Executioner.gd")

func _ready():
	pass

func load(world):
	var file = File.new()
	if load_saved_game and file.file_exists("user://savegame.json"):
		file.open("user://savegame.json", File.READ)
		var data = parse_json(file.get_as_text())
		file.close()

		#Player.from_dictionary(data.player)
		#ForestSpawnArea.from_dictionary(data.thieves)#Thieves spawn area
		#Executioner.from_dictionary(data.executioner)#Executioner
		
		world.from_dictionary(data)
