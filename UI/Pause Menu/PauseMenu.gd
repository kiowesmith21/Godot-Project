extends Popup


onready var player = get_node("/root/World/Player/Player")
var already_paused
var selected_menu


func _ready():
	pass # Replace with function body.

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("menu"):
			# Pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			# Show popup
			player.set_process_input(false)
			popup()
		for button in $".".get_children():
			selected_menu = button.connect("pressed", self, "on_button_pressed",[selected_menu])
		
func on_button_pressed(selected_menu):
	match selected_menu:
		0:
			if not already_paused:
				get_tree().paused = false
				player.set_process_input(true)
				hide()
		1:
			pass
		2:
			get_tree().quit()
