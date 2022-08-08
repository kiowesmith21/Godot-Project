extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var EventTrigger = get_node("EventTrigger")
onready var FMJSprite = get_node("AnimatedSprite")
onready var FMJParticles = get_node("CPUParticles2D")

var dialogue_state = 0
var dialogueUI
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogueUI = get_tree().root.get_node("/root/World/GameUI/DialogueUI2")
	player = get_tree().root.get_node("/root/World/Player/Player")


func _on_Area2D_area_entered(area):
	
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		FMJSprite.visible = true
		FMJParticles.visible = true
	pass # Replace with function body.

func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Future Merlin"

	match dialogue_state:
		0:
			dialogue_state = 1
			dialogueUI.dialogue = "What are you talking to me for? Go find the elder!"
			dialogueUI.choices = "[Q] Got it!"
			dialogueUI.open()
			print("Next option ", dialogue_state)
		1:
			dialogueUI.close()
			dialogue_state = 0




