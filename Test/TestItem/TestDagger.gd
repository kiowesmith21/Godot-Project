extends Area2D

var inventory 
onready var resource = preload("res://Test/TestItem/TestSword.tres")

func _ready():
	inventory = get_parent().get_node("GameUI/Inventory")

func _on_TestDagger_body_entered(body):
	if body.name == "Player":
		print("the player landed on me!")
		inventory._on_adding_item(resource)
