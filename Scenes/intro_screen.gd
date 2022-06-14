extends Control

var scene_path_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $Panel/Button.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])
		$TitleMusic.play()
		
func on_button_pressed(scene_to_load):
	var World = load("res://Scenes/World.tscn")
	add_child(World.instance())
	scene_path_to_load = World
	$TitleMusic.stop()
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)


