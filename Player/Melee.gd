extends Area2D

var speed = 400
var direction : Vector2
var atk_dmg = 25
var timer = Timer.new()
var Player = KinematicBody2D #it thinks player doesn't exist so when a new instance is run, it crashes

var knockback_vector = Vector2.ZERO

func _ready():
	$Sprite.rotation += Player.position.angle_to_point(get_local_mouse_position())

func _process(delta):
	#gets the position of the mouse 
	position = position + speed * delta * direction
	knockback_vector = direction
	
func Timer():
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()

func _on_Melee_body_entered(body):
	if body.name == "Player":
		return
	direction = Vector2.ZERO

func _get(property):
	return property

func _on_Melee_area_entered(area):
	queue_free()
