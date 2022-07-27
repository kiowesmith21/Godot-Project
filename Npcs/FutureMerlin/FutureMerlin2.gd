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
			dialogueUI.dialogue = "Remember that elder who showed you the way? Yeah, don’t trust that guy. He’s the reason we’re in this whole mess!"
			dialogueUI.choices = "[Q] Consider him dead!"
			dialogueUI.open()
			print("Next option ", dialogue_state)
		1:
			dialogue_state = 2
			dialogueUI.dialogue = "Calm down sport. For now just do exactly what he tells you."
			dialogueUI.choices = "[Q] Got it"
			dialogueUI.open()
			print("Next option ", dialogue_state)
		2:
			dialogueUI.close()
			dialogue_state = 0
