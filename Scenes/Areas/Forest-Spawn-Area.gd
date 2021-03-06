extends Area2D

const spawnTime = 3

enum{
	IDLE,
	SPAWN
}

var player = null
var state = IDLE
var thief = preload("res://Enemies/Thief/Thief.tscn")
var spawnCoolDown = 0

func can_see_player():
	return player != null
	
func _on_ForestSpawnArea_body_entered(body):
	player = body
	
func _on_ForestSpawnArea_body_exited(body):
	player = null


func seek_player():
	if can_see_player():
		state = SPAWN
	else:
		state = IDLE

func _physics_process(delta):
	
	match state:
		IDLE:
			seek_player()
		SPAWN:
			if(spawnCoolDown <= 0):
				var e_pos = player.position
				var enemy = thief.instance()
				
				if randf() < 0.5:
					e_pos.x -= rand_range(100.0, 200.0)
				else:
					e_pos.x += rand_range(100.0, 200.0)
					
				if randf() < 0.5:
					e_pos.y -= rand_range(50.0, 75.0)
				else:
					e_pos.y += rand_range(50.0, 75.0)
					
				enemy.position = e_pos
				add_child(enemy)
				spawnCoolDown = spawnTime
			else:
				spawnCoolDown = spawnCoolDown - delta
			seek_player()

func to_dictionary():
	var thieves = []
	for node in get_children():
		if node.name.find("Thief") >= 0:
			thieves.append(node.to_dictionary())
	return thieves

func from_dictionary(data):
	for thief_data in data:
		var enemy = thief.instance()
		enemy.from_dictionary(thief_data)
		add_child(enemy)
