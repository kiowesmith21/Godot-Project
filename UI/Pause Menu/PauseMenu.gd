extends Control

onready var player = get_node("/root/World/Player/Player")
onready var Enemies = get_node("/root/World/Enemies")
onready var ForestSpawnArea = get_node("/root/World/ForestSpawnArea")
var already_paused

func _ready():
	hide()

func _input(event):
	if Input.is_action_just_pressed("menu"):
		if already_paused:
			get_tree().paused = false
			already_paused = get_tree().paused
			hide()
		else:
			# Pause game
			get_tree().paused = true
			already_paused = get_tree().paused
			# Show popup
			show()

func _on_Resume_pressed():
	if already_paused:
		get_tree().paused = false
		player.set_process_input(true)
		hide()

func _on_Save_pressed():
	var data = {
		"player" : player.to_dictionary(),
		"thieves" : ForestSpawnArea.to_dictionary(),
		"executioner" : Enemies.get_child(0).to_dictionary()
	}
	var file = File.new()
	file.open("user://savegame.json", File.WRITE)
	var json = to_json(data)
	file.store_line(json)
	file.close()

func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to(load("res://UI/title-screen/TitleScreen.tscn"))
