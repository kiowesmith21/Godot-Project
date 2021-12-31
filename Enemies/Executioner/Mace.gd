extends Area2D

export var rotation_speed = PI
#onready var playerDetectionZone = get_node("root/World/Enemies/Executioner/PlayerDetectionZone")
var player
var Executioner

const SWINGWAIT = .25
var atk_swing_wait = .01

#var Player = preload("res://Player/Player.tscn")
var knockback_vector = Vector2.ZERO
var tilemap
var speed = 120
var direction : Vector2
var atk_dmg = 45
var atk_choice
var atk_time
var timer = Timer.new()

var swingUp = false

onready var swingTimer = $swingTimer

func _ready():
	
	atk_choice = 1#randi() % 2
	atk_time = setTimer("destroy",1.5)
	swingTimer = setTimer("swing",.7)
	player = get_tree().root.get_node("root/World/Player/Player")
	Executioner = get_parent()
	
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
		print(swingUp)
		if swingUp:
			position.y = position.y + 3 * delta * 90
			
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
	

	
#func atkTimer():
#	yield(get_tree().create_timer(.5), "timeout")

func _get(property):
	return property


