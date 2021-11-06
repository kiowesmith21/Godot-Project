extends KinematicBody2D

const ACCELERATION = 10
const  MAX_SPEED = 100
const FRICTION = .1
const COOLDOWN_WAIT_TIME = 1

var velocity  = Vector2.ZERO
var last_direction = Vector2(0, 1)

#player weapons/abilities
var atk_cooldown = 0
var atk_dmg = 0

var wpn_choice = 1
var fireball_given = false

#loading other scenes
var Melee = preload("res://Player/Melee.tscn")
var Fireball = preload("res://Player/Fireball.tscn")
var Arrow = preload("res://Player/Arrow.tscn")
var Bow = preload("res://Player/Bow And Arrow.tscn")

onready var stats = $PlayerStats
onready var anim = $AnimatedSprite
onready var hurtBox = $Hurtbox
onready var healthBar = get_node("/root/World/CanvasLayer/HealthBar") #healthbar

func _ready():
	stats.connect("no_health", self, "queue_free") #connect to player stats signal
	print(self.position)
	

#movement
func _physics_process(delta):
	var direction: Vector2
	var attack_direction = get_input(delta) #run get input to find attack input (weapon choice)
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	
	#handling diagonal movement 
	if (abs(direction.x) == 1 and abs(direction.y) == 1):
		direction = direction.normalized()
	
	if((direction.x > 0 or direction.x < 0) || (direction.y > 0 or direction.y < 0)):
		anim.flip_h = direction.x > 0 #flip the sprite to the direction we're facing
		anim.play("Walk")
	else:
		anim.play("Idle")
	var movement = MAX_SPEED * direction * delta
	move_and_collide(movement)
	
	if direction != Vector2.ZERO:
		$RayCast2D.cast_to = direction.normalized() * 8
	last_direction = direction

#weapon choices determine distance and damage. 
#sword = highest damage but closest distance while arrow = lowest damage but further distance
func attack(choice):
	#melee
	if (choice == 1):
		var m = Melee.instance()
		m.Player = self #Melee doesn't like this line :(
		get_parent().add_child(m)
		m.direction = (get_global_mouse_position() - position).normalized()
		m.transform = $MageHand.global_transform #shoots the projectile from the position of MageHand
		m.Timer()
	elif (choice == 2):
		var b = Bow.instance()
		get_parent().add_child(b)
		b.Player = self
		b.direction = (get_global_mouse_position() - position).normalized()
		b.transform = $MageHand.global_transform
		var a = Arrow.instance()
		a.Player = self
		get_parent().add_child(a)
		a.direction = (get_global_mouse_position() - position).normalized()
		a.transform = $MageHand.global_transform
		b.Timer()
		a.Timer()
	elif (choice == 3):
		if(fireball_given == true):
			var f = Fireball.instance()
			get_parent().add_child(f)
			f.direction = last_direction.normalized()
			f.transform = $MageHand.global_transform #shoots the projectile from the position of MageHand
			f.Timer()
		else:
			print("Fireball isn't given!")
		
	else:
		return
		

func get_input(delta):
	if(Input.get_action_strength("choose_weapon_1")):
		var m = Melee.instance()
		wpn_choice = 1
		atk_dmg = m.atk_dmg
	if(Input.get_action_strength("choose_weapon_2")):
		var a = Arrow.instance()
		wpn_choice = 2
		atk_dmg = a.atk_dmg
	elif(Input.get_action_strength("choose_weapon_3")):
		var f = Fireball.instance()
		wpn_choice = 3
		atk_dmg = f.atk_dmg
		
	
	if(atk_cooldown <= 0):
		if(Input.get_action_strength("shoot") > 0):
			attack(wpn_choice)
			atk_cooldown = COOLDOWN_WAIT_TIME
	else:
		atk_cooldown -= delta
	
	if(Input.get_action_strength("interact")):
		var target = $RayCast2D.get_collider()
		if target != null:
			if target.is_in_group("NPC"):
				target.talk()
				

#player getting hit, their hurtbox being entered
func _on_Hurtbox_area_entered(area):
	healthBar.set_value(stats.health - 20) #set healthbar value to new health
	stats.set_health(stats.health - 20) #set player's health to new health
	hurtBox.start_invincibility(0.5) 

