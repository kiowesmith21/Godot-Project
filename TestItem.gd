extends Area2D

var inventory 
var item1 = 0

func _ready():
	inventory = get_parent().get_node("GameUI/Inventory")
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		#background.m.v.grid.inv(item1).icon
		inventory.get_child(0).get_child(0).get_child(0).get_child(1).get_child(item1).get_child(0).set_texture(self.get_child(0).get_texture())
		item1 += 1
