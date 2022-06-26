extends Area2D

var invincible = false setget set_invincible

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value 
	if invincible == true:
		emit_signal("invincibility_started")
		#print_debug("invincible")
	else:
		emit_signal("invincibility_ended")
		#print_debug("not invincible")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func invincibility_ended():
	self.invincible = false
	
func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)

func _on_Hurtbox_invincibility_ended():
	monitorable = true
