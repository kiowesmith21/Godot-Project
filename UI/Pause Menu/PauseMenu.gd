extends Control

onready var player = get_node("/root/World/Player/Player")
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
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
