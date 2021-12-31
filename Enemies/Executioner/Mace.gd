extends Area2D

export var rotation_speed = PI
#onready var playerDetectionZone = get_node("root/World/Enemies/Executioner/PlayerDetectionZone")
var player

#var Player = preload("res://Player/Player.tscn")
var knockback_vector = Vector2.ZERO
var tilemap
var speed = 120
var direction : Vector2
var atk_dmg = 45
var atk_choice
var timer = Timer.new()

var swingUp = false

onready var swingTimer = $swingTimer

func _ready():
	atk_choice = 1#randi() % 2
	Timer()
	player = get_tree().root.get_node("root/World/Player/Player")

func _process(delta):
	print(atk_choice)
	if(atk_choice == 0):
		rotation += rotation_speed * delta
	elif(atk_choice == 1):
		print(position)
		position.move_toward(Vector2(position.x,position.y+100), delta * speed)#change this to move towards the executioner's position plus the height of where it's gonna move
		#swingTimer.start()
		#if swingUp:
		#position.move_toward(Vector2(global_position.x,global_position.y+300), delta * 360)
	else:
		if player != null:
			var direction = (player.position - position).normalized()
		global_position = global_position.move_toward(direction * 240, delta * 240)
		print(direction)
		print(global_position)

func _on_Mace_body_entered(body):
	if body.name == "Player":
		return queue_free()
	direction = Vector2.ZERO
	
func Timer():
	yield(get_tree().create_timer(1.5), "timeout")
	queue_free()
	
#func atkTimer():
#	yield(get_tree().create_timer(.5), "timeout")

func _get(property):
	return property


func _on_Timer_timeout():
	swingUp = true
	swingTimer.start()
