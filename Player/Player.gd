extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = .1
const COOLDOWN_WAIT_TIME = 1

var velocity  = Vector2.ZERO
var last_direction = Vector2(0, 1)

#player weapons/abilities
var atk_cooldown = 0
var atk_dmg = 25

var wpn_choice = 1
var fireball_given = false
var gettingHit = false
var playerArea 
#loading other scenes
var Melee = preload("res://Player/Weapons/Melee.tscn")
var Fireball = preload("res://Player/Weapons/Fireball.tscn")
var Arrow = preload("res://Player/Weapons/Arrow.tscn")
var Bow = preload("res://Player/Weapons/Bow And Arrow.tscn")

onready var stats = $PlayerStats
onready var anim = $AnimatedSprite
onready var hurtBox = $Hurtbox
onready var healthBar = get_parent().get_parent().get_node("GameUI/HealthBar") #healthbar
onready var armorBar = get_parent().get_parent().get_node("GameUI/ArmorBar")

func _ready():
	stats.connect("no_health", self, "die") #connect to player stats signal
	global_position = $PlayerStats.global_pos

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
		$RayCast2D.cast_to = direction.normalized() * 20
	last_direction = direction
	
	if gettingHit == true && hurtBox.invincible == false: #check if playing is being hit and is not invincible every frame
		
		#print_debug("PLAYER BEING HIT")
		$hurtSound.play()
		if(armorBar.armor > 0):
			armorBar.set_value(stats.armor - playerArea.get_parent().atk_dmg)
			stats.set_armor(stats.armor - playerArea.get_parent().atk_dmg)
		else:
			healthBar.set_value(stats.health - playerArea.get_parent().atk_dmg) #set healthbar value to new health
			#player loses health on hit
			stats.set_health(stats.health - playerArea.get_parent().atk_dmg)
		hurtBox.start_invincibility(1.0) #player invincible for a second so doesnt instantly die
		
	
#weapon choices determine distance and damage. 
#sword = highest damage but closest distance while arrow = lowest damage but further distance
func attack(choice):
	#melee
	if (choice == 1):
		var m = Melee.instance()
		m.Player = self
		get_parent().add_child(m)
		m.direction = (get_global_mouse_position() - position).normalized()
		m.transform = $MageHand.global_transform #shoots the projectile from the position of MageHand
		m.Timer()
	elif (choice == 2):
		var b = Bow.instance()
		b.Player = self
		get_parent().add_child(b)
		b.position = position
		b.transform = $MageHand.global_transform
		b.direction = (get_global_mouse_position() - position).normalized()
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
		print(target)
		if target != null:
			if target.is_in_group("NPC"):
				target.talk()

#player getting hit, their hurtbox being entered
func _on_Hurtbox_area_entered(area):
	gettingHit = true
	playerArea = area
	
	

#death
func die():
	if !$deathSound.is_playing():
		$deathSound.play(0.0)
		print_debug("Player Death:" + str($deathSound.is_playing()))
		yield(get_tree().create_timer(2.2), "timeout")
	
	queue_free()#delete player
	
func to_dictionary(): #made to save the player's data
	return {
		"position" : [global_position.x, global_position.y],
		"health" : stats.health,
		"armor": stats.armor,
		"fireball_given": fireball_given
	}

func from_dictionary(data):
	global_position = Vector2(data.position[0], data.position[1])
	PlayerStats.global_pos = global_position
	stats.health = data.health
	stats.armor = data.armor
	fireball_given = data.fireball_given

#player not getting hit, their hurtbox has been exited
func _on_Hurtbox_area_exited(area):
	gettingHit = false
