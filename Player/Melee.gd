extends Area2D

var speed = 300
var direction : Vector2
var atk_dmg = 25
var timer = Timer.new()
var Player

var knockback_vector = Vector2.ZERO

func _ready():
	$Sprite.rotation += Player.position.angle_to_point(get_local_mouse_position())

func _process(delta):
	#gets the position of the mouse for the fireball so the fireball follows the mouse
	direction = (get_global_mouse_position() - position).normalized()
	position = position + speed * delta * direction
	knockback_vector = direction
	
func Timer():
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()

func _on_Melee_body_entered(body):
	if body.name == "Player":
		return
	direction = Vector2.ZERO

func _get(property):
	return property
