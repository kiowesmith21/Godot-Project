extends KinematicBody2D 

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 500

enum {
	IDLE,
	WANDER,
	CHASE
}

#death effect
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
#death sound 
const Sound = preload("res://Sound/sfx/EnemyDie.wav")
#hit effect
const HitEffect = preload("res://Effects/HitEffect.tscn")
#spawn effect
const EnemySpawnEffect = preload("res://Effects/EnemySpawnEffect.tscn")

var Player = preload("res://Player/Player.tscn")

var attacking = false

var atk_dmg = 20

var knockback = Vector2.ZERO

var velocity = Vector2.ZERO

var state = CHASE

var clock = Timer.new()
onready var stats = $ThiefStats
onready var anim = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone 
onready var hurtBox = $Hurtbox
onready var softCollision = $SoftCollision

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.hide()
	var enemySpawnEffect = EnemySpawnEffect.instance()
	get_parent().call_deferred("add_child",enemySpawnEffect)
	enemySpawnEffect.global_position = global_position
	$AnimatedSprite.show()
	stats.connect("no_health", self, "die") #connect to stats signal, runs die() function when it reaches 0 health
	#stats.set_max_health(50)
	Player = get_parent().get_parent().get_node("Player/Player")

func _physics_process(delta):
	
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) #friction
			anim.play("Idle")
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			if attacking:
				
				anim.play("Melee")
			else:
				anim.play("Walk")
			anim.flip_h = velocity.x < 0 #flip the sprite to the direction we're facing
	
	#enemies have soft collisions with each other
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

#hitting the enemy
func _on_Hurtbox_area_entered(area):
	
	#hit effect
	var hitEffect = HitEffect.instance()
	get_parent().add_child(hitEffect)
	hitEffect.global_position = Vector2(global_position.x + 6, global_position.y + 15) #spawn the effect in the middle of the sprite
	#knockback
	knockback = area.knockback_vector * 150 #this value changes how far enemy gets knocked back, needs to be knocked back based on player direction
	#enemy loses health on hit
	print(Player.atk_dmg)#this bug causes a crash when boss walks on player
	stats.set_health(stats.health - Player.atk_dmg)
	#play hit sound effect
	$hitSound.play()

#when enemy enters player's hurtbox (hits the player)
func _on_Hitbox_area_entered(area):
	attacking = true

func _on_Hitbox_area_exited(area):
	attacking = false
	
func die():
	if !$deathSound.is_playing():
		$deathSound.play(0.0)
		yield(get_tree().create_timer(0.25), "timeout")
	print_debug("Thief Death:" + str($deathSound.is_playing()))
	
		
	
	
	queue_free() #delete enemy
	#death effect
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func to_dictionary():
	return {
		"position": [global_position.x, global_position.y],
		"health" : stats.health
	}

func from_dictionary(data):
	global_position = Vector2(data.position[0], data.position[1])

