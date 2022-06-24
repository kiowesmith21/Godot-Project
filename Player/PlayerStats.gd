extends Node

export(int) var max_health = 100
export(int) var health = max_health setget set_health

export(int) var max_armor = 50
export(int) var armor = max_armor setget set_armor

export(int) var curr_wpn = 1
onready var wpn_choice = curr_wpn

export(bool)var fireball
export(bool) var fireball_given = fireball setget set_fireball

var global_pos: Vector2
var saved_pos: Vector2


signal no_health
signal health_changed(value)
signal max_health_changed(value)

signal no_armor
signal armor_changed(value)
signal max_armor_changed(value)

signal fireball_given

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_armor(value):
	armor = value
	emit_signal("armor_changed", armor)
	if armor <= 0:
		emit_signal("no_armor")

signal wpn_change(choice)

func set_weapon(choice):
	wpn_choice = choice
	emit_signal("wpn_change", wpn_choice)

func set_fireball(choice):
	fireball_given = choice

func _ready():
	print("stats ready ", fireball_given)
	self.health = max_health
	self.armor = 0
