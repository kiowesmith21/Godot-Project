extends Control

var health = 100 setget set_health
var max_health = 100 setget set_max_health

onready var enemyHealthBar = $ProgressBar

func set_health(value):
	health = clamp(value, 0, max_health)
	enemyHealthBar.value = health

func set_max_health(value):
	max_health = max(value, 1)
	self.health = min(health, max_health)
	enemyHealthBar.value = max_health
	
func _ready():
	self.max_health = 100
	self.health = 100

	
