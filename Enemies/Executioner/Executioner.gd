extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 500

enum {
	IDLE,
	CHASE
}

#death effect
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
#hit effect
const HitEffect = preload("res://Effects/HitEffect.tscn")
#spawn effect
const EnemySpawnEffect = preload("res://Effects/EnemySpawnEffect.tscn")

var Player = preload("res://Player/Player.tscn")

var Mace = preload("res://Enemies/Executioner/Mace.tscn")

var armorDrop = preload("res://Player/Armor.tscn")

var atk_dmg = 40

var knockback = Vector2.ZERO

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var state = IDLE

var myDelta = 0

var atk_cooldown = 0

const COOLDOWN_WAIT_TIME = 10

var attackAllowed = true

onready var timer = $Timer
onready var stats = $ExecutionerStats
onready var anim = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone 
onready var hurtBox = $Hurtbox
onready var softCollision = $SoftCollision


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.hide()
	$AnimatedSprite.show()
	stats.connect("no_health", self, "die") #connect to stats signal, runs die() function when it reaches 0 health
	#stats.set_max_health(50)
	Player = get_tree().root.get_node("/root/World/Player/Player")

func _physics_process(delta):
	myDelta = delta

	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) #friction
			anim.play("Idle")
			seek_player()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * myDelta)
				if direction != Vector2.ZERO:
					$RayCast2D.cast_to = direction.normalized() * 8
					attack()
				else:
					velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * myDelta)
					anim.play("Walk")
			else:
				state = IDLE
	
	#enemies have soft collisions with each other
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
		
func attack():
	if attackAllowed:
		var M = Mace.instance()
		attackAllowed = false
		get_parent().add_child(M)
		M.transform = $MaceHand.global_transform
		M.direction = direction
		anim.flip_h = velocity.x < 0 #flip the sprite to the direction we're facing
		attackAllowed = false
		timer.start() #cooldown start

#hitting the enemy
func _on_Hurtbox_area_entered(area):
	#hit effect
	var hitEffect = HitEffect.instance()
	get_parent().add_child(hitEffect)
	hitEffect.global_position = Vector2(global_position.x + 6, global_position.y + 15) #spawn the effect in the middle of the sprite
	#knockback
	knockback = area.knockback_vector * 150 #this value changes how far enemy gets knocked back, needs to be knocked back based on player direction
	#enemy loses health on hit
	stats.set_health(stats.health - Player.atk_dmg)
	#print("Enemy Health: " + str(stats.health))

func die():
	#death effect
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	anim.visible = false
	var a = armorDrop.instance()
	get_parent().add_child(a)
	a.transform = $MaceHand.global_transform
	queue_free() #delete enemy

func _on_Timer_timeout():
	attackAllowed = true 
	timer.start()

func to_dictionary():
	return {
		"position" : [global_position.x, global_position.y],
		"health" : stats.health
	}

func from_dictionary(data):
	global_position = Vector2(data.position[0], data.position[1])
	stats.health = data.health
