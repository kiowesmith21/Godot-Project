extends Area2D

export var rotation_speed = PI
#onready var playerDetectionZone = get_node("root/World/Enemies/Executioner/PlayerDetectionZone")

var Player = preload("res://Player/Player.tscn")
var knockback_vector = Vector2.ZERO
var tilemap
var speed = 120
var direction : Vector2
var atk_dmg = 45
var atk_choice
var timer = Timer.new()

func _ready():
	atk_choice = randi() % 2
	Timer()

func _process(delta):
	if(atk_choice == 0):
		rotation += rotation_speed * delta
	elif(atk_choice == 1):
		global_position = global_position + global_position.move_toward(Vector2(global_position.x,global_position.y-100), delta * speed)
		atkTimer()
		global_position = global_position + global_position.move_toward(Vector2(global_position.x,global_position.y+300), delta * 360)
	else:
		#var player = playerDetectionZone.player
		#if player != null:
			#var direction = (player.global_position - global_position).normalized()
		global_position = global_position.move_toward(direction, delta * 240)


func _on_Mace_body_entered(body):
	if body.name == "Player":
		return queue_free()
	direction = Vector2.ZERO
	
func Timer():
	yield(get_tree().create_timer(1.5), "timeout")
	queue_free()
	
func atkTimer():
	yield(get_tree().create_timer(.5), "timeout")

func _get(property):
	return property
