extends Control

var max_health = 100
var health = max_health

onready var healthBar = $ProgressBar

func set_value(value):
	health = clamp(value, 0, max_health)
	healthBar.value = health
	print("Healthbar: " + str(healthBar.value))

func _ready():
	self.set_value(max_health) #set value of health bar to 100
