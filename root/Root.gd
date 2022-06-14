extends Node2D


var titleScreen = preload("res://Scenes/title-screen/TitleScreen.tscn")
var worldScene = preload("res://Scenes/World.tscn")

var load_saved_game = false

var world

var player = preload("res://Player/Player.gd")
var ForestSpawnArea = preload("res://Scenes/Areas/Forest-Spawn-Area.gd")
var executioner = preload("res://Enemies/Executioner/Executioner.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


