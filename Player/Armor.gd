extends Area2D

var armorGiven = 25
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_node("/root/World/Player/Player")


func _on_Armor_body_entered(body):
	if body.name == "Player":
		print(player.armorBar.armor, "before")
		player.armorBar.set_value(armorGiven)
		print(player.armorBar.armor, "after")
		queue_free()
