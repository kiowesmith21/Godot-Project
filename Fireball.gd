extends Area2D

var knockback_vector = Vector2.ZERO

var tilemap
var speed = 120
var direction : Vector2
var atk_dmg = 20
var timer = Timer.new()

func _process(delta):
	#gets the position of the mouse for the fireball so the fireball follows the mouse
	direction = (get_global_mouse_position() - position).normalized()
	position = position + speed * delta * direction
	
func _on_Fireball_body_entered(body):
	if body.name == "Player":#add for what happens to the player and for when it goes to an enemy
		return queue_free()
	direction = Vector2.ZERO
	
func Timer():
	yield(get_tree().create_timer(0.75), "timeout")
	queue_free()

func _get(property):
	return property
	
func _on_Fireball_area_entered(area):
	queue_free()
