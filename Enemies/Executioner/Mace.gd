extends Area2D

export var rotation_speed = PI
#onready var playerDetectionZone = get_node("root/World/Enemies/Executioner/PlayerDetectionZone")
var player
var Executioner

const SWINGWAIT = .25
var atk_swing_wait = .01

#var Player = preload("res://Player/Player.tscn")
var knockback_vector = Vector2.ZERO
var direction
var tilemap
var speed = 120
var atk_dmg = 45
var atk_choice
var atk_time
var timer = Timer.new()

var swingUp = false

onready var swingTimer = $swingTimer

func _ready():
	print("im a new mace")
	atk_choice = randi() % 2
	if(atk_choice == 0):
		atk_time = setTimer("destroy",1.5)
	elif (atk_choice == 1):
		atk_time = setTimer("destroy",1.5)
		swingTimer = setTimer("swing",.7)
	else:
		atk_time = setTimer("destroy",.5)
	Executioner = get_parent().get_child(0)
	player = Executioner.get_child(2).player
	
func setTimer(spawn_func, spawn_time) -> Timer:
	var timer = Timer.new()
	add_child (timer)
	timer.set_wait_time(spawn_time)
	timer.connect("timeout", self, spawn_func) 
	timer.start()
	return timer

func destroy():
	queue_free()

func swing():
	swingUp = true

func _process(delta):
	if(atk_choice == 0):
		rotation += rotation_speed * delta
	elif(atk_choice == 1):
		position.y = position.y - 1.5 * delta * 90
		if swingUp:
			position.y = position.y + 3 * delta * 90
	else:
		if player != null:#doesn't go to the player
			position = position + 150 * direction * delta

func _on_Mace_body_entered(body):
	if body.name == "Player":
		return queue_free()
	

	
#func atkTimer():
#	yield(get_tree().create_timer(.5), "timeout")

func _get(property):
	return property


