extends Node

export(int) var max_health = 4 setget set_max_health
export(int) var health = max_health setget set_health

export(int) var curr_wpn = 1
onready var wpn_choice = curr_wpn

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

signal wpn_change(choice)

func set_weapon(choice):
	wpn_choice = choice
	emit_signal("wpn_change", wpn_choice)
	
func _ready():
	self.health = max_health

