extends KinematicBody2D

var dialogue_state = 0

var dialogueUI
var player

func _ready():
	dialogueUI = get_tree().root.get_node("/root/World/CanvasLayer/DialogueUI")
	player = get_tree().root.get_node("/root/World/Player/Player")

func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "King"
	

	match dialogue_state:
		0:
			dialogue_state = 1
			dialogueUI.dialogue = "What are you talking to me for? Go find the elder!"
			dialogueUI.choices = "[Q] Got it!"
			dialogueUI.open()
		1:
			dialogueUI.close()
			dialogue_state = 0
