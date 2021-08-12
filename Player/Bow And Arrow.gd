extends Area2D
var direction

func _process(_delta):
	look_at(get_global_mouse_position())

