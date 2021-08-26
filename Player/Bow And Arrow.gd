extends Area2D

var direction

func _process(_delta):
	look_at(get_global_mouse_position())

func Timer():
	yield(get_tree().create_timer(0.25), "timeout")
	queue_free()
