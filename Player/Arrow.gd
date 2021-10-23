extends Area2D
const FRICTION = .05
const ACCELERATION = .25
const MAX_SPEED = 500

var speed = 500
var direction : Vector2
var atk_dmg = 15
var Player

var knockback_vector = Vector2.ZERO

func _ready():
	$ArrowSprite.rotation += Player.position.angle_to_point(get_local_mouse_position())

func _process(delta):
	position = position + speed * delta * direction
	knockback_vector = direction

func _on_Arrow_body_entered(body):
	if body.name == "Player":
		return
	direction = Vector2.ZERO
	
func Timer():
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()

func _get(property):
	return property


func _on_Arrow_area_entered(area):
	queue_free()
