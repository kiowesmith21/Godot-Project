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

var attacking = false

var Mace = preload("res://Enemies/Executioner/Mace.tscn")

var atk_dmg = 40

var knockback = Vector2.ZERO

var velocity = Vector2.ZERO

var state = CHASE

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
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				if direction != Vector2.ZERO:
					$RayCast2D.cast_to = direction.normalized() * 8
				if attacking:
					while attacking:
						var M = Mace.instance()
						attacking = false
						print("Attacking")
						get_parent().add_child(M)
						M.transform = $MaceHand.global_transform
						if(M.atk_choice == 0):
							yield(get_tree().create_timer(4), "timeout")
						elif(M.atk_choice == 1):
							yield(get_tree().create_timer(5), "timeout")
						attacking = true
				else:
					anim.play("Walk")
			else:
				state = IDLE
			
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
	print(Player.atk_dmg)
	stats.set_health(stats.health - Player.atk_dmg)
	#print("Enemy Health: " + str(stats.health))

#when player enters the detection zone (hits the player)
func _on_PlayerDetectionZone_body_entered(area):
	attacking = true
	
func _on_PlayerDetectionZone_body_exited(area):
	attacking = false
	
func die():
	queue_free() #delete enemy
	#death effect
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
