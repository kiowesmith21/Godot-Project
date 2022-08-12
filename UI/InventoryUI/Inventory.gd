extends Control


var already_pressed
var free_item = 0

var drag_data = null

signal items_changed(indexes)

export(Array, Resource) var items = [
	null, null, null, null, null, null, null, null, null,
]

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
	
func set_item(item_index, item):
	print(item is Item)
	var previousItem = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previousItem

func swap_items(item_index, target_item_index):
	var targetItem = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = targetItem
	emit_signal("items_changed", [item_index, target_item_index])

func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem

func make_items_unique():
	var unique_items = []
	for item in items:
		if item is Item:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
	items = unique_items

func _on_adding_item(item):
	#set the inventory texture as the pic of the item
	#get_child(0).get_child(0).get_child(0).get_child(1).get_child(free_item).get_child(0).set_texture(item.get_child(0).get_texture())
	#set the name of the inventory label the same as the item
	#get_child(0).get_child(0).get_child(0).get_child(1).get_child(free_item).get_child(1)
	#future stuff to do -> draggable items to move between the inventory and hot bar
	if(free_item < 9):
		print(item is Item)
		set_item(free_item,item)
		free_item += 1

