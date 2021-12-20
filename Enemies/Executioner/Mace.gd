extends Area2D

export var rotation_speed = PI
var Player = preload("res://Player/Player.tscn")
var Executioner
var knockback_vector = Vector2.ZERO
var tilemap
var speed = 120
var direction : Vector2
var atk_dmg = 45
var atk_choice
var timer = Timer.new()

func _ready():
	atk_choice = randi() % 3
	print("i am here", atk_choice)
	if(atk_choice == 0):#circle
		position = $Executioner.position + 50
		
	elif(atk_choice == 1):#up and smash
		position = $Executioner.position + 50
		
	else:#throw
		position = $Executioner.position + 50

func _process(delta):
	if(atk_choice == 0):
		rotation += rotation_speed * delta
	elif(atk_choice == 0):
		position = position.move_toward(Vector2(position.x,position.y+100), delta * speed)
		position = position.move_toward(Vector2(position.x,Executioner.position.y-100), delta * 360)
	else:
		position = position.move_toward(Vector2(Player.position.x,Player.position.x), delta * 240)


func _on_Mace_body_entered(body):
	if body.name == "Executioner":
		return queue_free()
	direction = Vector2.ZERO
	
func Timer():
	yield(get_tree().create_timer(1.5), "timeout")
	queue_free()

func _get(property):
	return property
