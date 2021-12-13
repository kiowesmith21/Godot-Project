extends Area2D

var direction
var Player

func _process(_delta):
	self.position.x = Player.position.x
	self.position.y = Player.position.y - self.position.y
	look_at(get_global_mouse_position())

func Timer():
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
