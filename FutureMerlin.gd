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
			dialogueUI.dialogue = "Well hello you must be Merlin Jr. Nice to meet you. I’m also Merlin Jr."
			dialogueUI.choices = "[E] Huh?"
			dialogueUI.open()
		1:
			match choice:
				"E":
					dialogue_state = 2 
					dialogueUI.dialogue = "I’m on a quest of my own, so there’s no time to be confused. Try to keep up, yeah?"
					dialogueUI.choices = "[E] Uh, I'll try."
					dialogueUI.open()
		2:
			match choice:
				"E":
					dialogue_state = 3
					dialogueUI.dialogue = "I’m here from the future to let you know how your life will turn out."
					dialogueUI.choices = "[E] Go on."
					dialogueUI.open()
		3:
			match choice:
				"E":
					dialogue_state = 4
					dialogueUI.dialogue = "You’ll kill your friends, your childhood heroes, and even your father. Shall we get started?"
					dialogueUI.choices = "[Q] Do I really have a choice?"
					dialogueUI.open()
		4:
			# not being executed 
			match choice:
				"Q":
					dialogue_state = 5
					dialogueUI.dialogue = "Ha! Of course not. Now go find the elders so we can get started."
					dialogueUI.choices = "[E] Well alright, I guess."
					dialogueUI.open()
			
		5:
			dialogueUI.close()
			dialogue_state = 0

