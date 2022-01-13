extends Control

var scene_path_to_load

onready var button = $VBoxContainer/BackButton

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])
		
func on_button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load)
