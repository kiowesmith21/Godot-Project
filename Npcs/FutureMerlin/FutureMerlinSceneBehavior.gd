extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var EventTrigger = get_node("EventTrigger")
onready var FMJSprite = get_node("AnimatedSprite")
onready var FMJParticles = get_node("CPUParticles2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		FMJSprite.visible = true
		FMJParticles.visible = true
	pass # Replace with function body.
