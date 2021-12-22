extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_PlayerAttackZone_body_entered(body):
	player = body

func _on_PlayerAttackZone_body_exited(body):
	player = null
