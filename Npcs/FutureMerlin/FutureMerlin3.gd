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

signal FMJAppears
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
		emit_signal("FMJAppears")
	pass # Replace with function body.

func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Future Merlin"

	match dialogue_state:
		0:
			dialogue_state = 1
			dialogueUI.dialogue = "That was a great warm up round! Any questions before the real fun starts? "
			dialogueUI.choices = "[Q]So, you were kidding earlier right? When you said we… I mean I killed my friends?"
			dialogueUI.open()
			print("Next option ", dialogue_state)
		1:
			dialogue_state = 2
			dialogueUI.dialogue = "Nope, remember Archie?  Well he’s Archie the executioner now. You’ll be fighting him next. "
			dialogueUI.choices = "[Q] Well shit."
			dialogueUI.open()
			print("Next option ", dialogue_state)
		2:
			dialogueUI.close()
			dialogue_state = 0




