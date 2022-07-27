extends KinematicBody2D

var dialogue_state = 0

var dialogueUI
var player

func _ready():
	dialogueUI = get_tree().root.get_node("/root/World/GameUI/DialogueUI2")
	player = get_tree().root.get_node("/root/World/Player/Player")

func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Mary"
	
	match dialogue_state:
		0:
			dialogue_state = 1
			dialogueUI.dialogue = "Hello traveler. I hope you’re not going into the forest. There’s bandits everywhere."
			dialogueUI.choices = "[E] That’s exactly why I’m here. I need weapons to fight them. Can you help me?"
			dialogueUI.open()
			print("Next option ", dialogue_state)
		1:
			dialogue_state = 2
			dialogueUI.dialogue = "Sorry, we’ve been wiped clean. Everyone is scared for their lives. Come back later and I may have something"
			dialogueUI.choices = "[Q] I'll try and come back if I'm not chopped in half."
			dialogueUI.open()
		2:
			dialogue_state = 0
			dialogueUI.close()
	
