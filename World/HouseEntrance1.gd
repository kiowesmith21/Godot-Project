extends Area2D


var change_to_scene = preload("res://HouseScenes/House1.tscn")
export (Vector2) var move_to_position

func _ready():
	if PlayerStats.player_position:
		get_node("Player").global_position = PlayerStats.player_position

func _on_HouseEntrance1_body_entered(body):
		#when the player touches the collision area, they are transported to the 1st house
	if change_to_scene and move_to_position:
		PlayerStats.global_position = move_to_position
		get_tree().change_scene_to(change_to_scene)
