extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 500

enum {
	IDLE,
	WANDER,
	CHASE
}

var attacking = false

var knockback = Vector2.ZERO

var velocity = Vector2.ZERO

var state = CHASE

onready var stats =  $Stats
onready var anim = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone 
onready var hurtBox = $Hurtbox

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.connect("no_health", self, "queue_free") #connect to stats signal, will delete enemy when it reaches 0 health

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
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

#hitting the enemy
func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * 250 #this value changes how far enemy gets knocked back, needs to be knocked back based on player direction
	#enemy loses health on hit
	stats.set_health(stats.health - 1)

#when enemy enters player's hurtbox (hits the player)
func _on_Hitbox_area_entered(area):
	attacking = true

func _on_Hitbox_area_exited(area):
	attacking = false
