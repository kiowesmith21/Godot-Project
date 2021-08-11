extends Area2D
var direction

func _process(_delta):
	direction = (get_global_mouse_position() - position).normalized()
	position = position * direction

