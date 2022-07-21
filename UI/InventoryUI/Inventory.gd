extends Control


var already_pressed
var free_item = 0

func _ready():
	hide()

func _input(_event):
	if Input.is_action_just_pressed("inventory"):
		if already_pressed:#unpausing the game
			already_pressed = false
			hide()
			#get_tree().paused = false
			#already_pressed = get_tree().paused
		else:
			already_pressed = true
			# Pause game
			#get_tree().paused = true
			#already_pressed = get_tree().paused
			# Show popup
			show()


func _on_Button_pressed():
	hide()
	already_pressed = false
	

func _on_adding_item(item):
	#set the inventory texture as the pic of the item
	get_child(0).get_child(0).get_child(0).get_child(1).get_child(free_item).get_child(0).set_texture(item.get_child(0).get_texture())
	#set the name of the inventory label the same as the item
	#get_child(0).get_child(0).get_child(0).get_child(1).get_child(free_item).get_child(1)
	#future stuff to do -> draggable items to move between the inventory and hot bar
	free_item += 1

