extends Area2D
var direction

var Arrow = preload("res://Player/Arrow.tscn")

func _process(_delta):
	direction = (get_global_mouse_position() - position).normalized()
	position = position * direction

func shoot():
	if(Input.get_action_strength("shoot") > 0):
		var a = Arrow.instance()
		a.direction = (get_global_mouse_position() - position).normalized()
		get_parent().add_child(a)
		a.transform = $ArrowExit.global_transform
		
func Timer():
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
