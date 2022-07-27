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
	dialogueUI.npcname = "Future Merlin"

	match dialogue_state:
		0:
			dialogue_state = 1
			dialogueUI.dialogue = "That was a great warm up round! Any questions before the real fun starts?"
			dialogueUI.choices = "[Q]So, you were kidding earlier right? When you said we… I mean I killed dad?"
			dialogueUI.open()
			print("Next option ", dialogue_state)
		1:
			dialogue_state = 2
			dialogueUI.dialogue = "Nope, you’ll be fighting him soon. Should be a piece of cake anyways. The old man has gotten soft with age."
			dialogueUI.choices = "[Q]Shit..."
			dialogueUI.open()
			print("Next option ", dialogue_state)
		2:
			dialogueUI.close()
			dialogue_state = 0
