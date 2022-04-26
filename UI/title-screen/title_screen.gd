extends Control

var scene_path_to_load
var load_saved_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#have player spawn location be the correct position when loading in after clicking new game
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])
		$TitleMusic.play()
		
func on_button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$TitleMusic.stop()
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)



func _on_NewGame_pressed():
	scene_path_to_load = ("res://UI/Intro.tscn")
	PlayerStats.global_pos = Vector2(23,130)
	$TitleMusic.stop()
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_Load_Game_pressed():
	var file = File.new()
	if load_saved_game and file.file_exists("user://savegame.json"):
		file.open("user://savegame.json", File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		
		$Player.from_dictionary(data.player)
		$ForestSpawnArea.from_dictionary(data.player)#Thieves spawn area
		$Enemies.get_child(0).from_dictionary(data.player)#Executioner

	var world_resource = load("res://World.tscn")
	var world = world_resource.instance()
	world.load_saved_game = true
	scene_path_to_load = (world)
	$TitleMusic.stop()
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_ControlsButton_pressed():
	scene_path_to_load = ("res://UI/title-screen/Controls.tscn")
	$TitleMusic.stop()
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_QuitGame_pressed():
	get_tree().quit()
