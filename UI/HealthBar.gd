extends Control

var health = 4 setget set_health
var max_health = 4 setget set_max_health

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_health(value):
	health = clamp(value, 0, max_health)
	if heartUIFull != null:
		heartUIFull.rect_size.x = health * 15 #each heart is 15 pixels wide, so set the texture + or - 15 pixels to show or remove each heart

func set_max_health(value):
	max_health = max(value, 1)
	self.health = min(health, max_health)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_health * 15
	
func _ready():
	self.max_health = PlayerStats.max_health
	self.health = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_health")
	PlayerStats.connect("max_health_changed", self, "set_max_health")
