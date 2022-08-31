extends KinematicBody2D

var dialogue_state = 0

var dialogueUI
var player

func _ready():
	dialogueUI = get_parent().get_parent().get_node("GameUI/DialogueUI2")
	player = get_parent().get_parent().get_node("Player/Player")

func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Jim"
	
	match dialogue_state:
		0:
			dialogue_state = 1
			dialogueUI.dialogue = "Merlin is that you? Thank God you’re here to save us! "
			dialogueUI.choices = "[E] I have to find this spell book first. Do you know where it is? "
			dialogueUI.open()
		1:
			dialogue_state = 2
			dialogueUI.dialogue = "Nope, but good luck! "
			dialogueUI.choices = "[Q] Thank you!"
			dialogueUI.open()
		2:
			dialogue_state = 0
			player.talkingStat = false
			dialogueUI.close()
	



