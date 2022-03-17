extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerStats.player_position:
		get_node("Player").global_position = PlayerStats.player_position
		
func _process(delta):
	print("player is in scene")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
