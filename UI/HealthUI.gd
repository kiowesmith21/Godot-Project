extends Control

var health = 4 setget set_health
var max_health = 4 setget set_max_health

onready var label = $Label

func set_health(value):
	health = clamp(value, 0, max_health)
	if label != null:
		label.text = "HP: " + str(health)

func set_max_health(value):
	max_health = max(value, 1)
	
func _ready():
	self.max_health = PlayerStats.max_health
	self.health = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_health")
