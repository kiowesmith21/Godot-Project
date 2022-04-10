extends Popup


onready var player = get_node("/root/World/Player/Player")
var already_paused
var selectedMenu


func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("menu"):
		if already_paused:
			get_tree().paused = false
			already_paused = false
			hide()
		else:
			# Pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# Show popup
			popup()

func _on_Resume_pressed():
	if not already_paused:
		get_tree().paused = false
		player.set_process_input(true)
		hide()

func _on_Save_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
