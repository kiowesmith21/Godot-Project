extends Area2D
const FRICTION = .05
const ACCELERATION = .25
const MAX_SPEED = 500

var speed = 500
var direction = 1
var atk_dmg

func _process(delta):
	if(speed >= 0):
		speed = lerp(speed,MAX_SPEED,ACCELERATION)
	else:
		speed = lerp(speed,Vector2.ZERO,FRICTION)
	position = position + speed * delta * direction

func _on_Arrow_body_entered(body):
	if body.name == "Player":
		return
	direction = Vector2.ZERO
	
func Timer():
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()


