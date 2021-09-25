extends KinematicBody2D

#Quests
#Starting Quest
#player has to get stolen spellbook from bandits
#will receive fireball as reward
enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED
var spellbook_found = false

var dialogue_state = 0

var dialogueUI
var player

func _ready():
	dialogueUI = get_tree().root.get_node("/root/World/CanvasLayer/DialogueUI")
	player = get_tree().root.get_node("/root/World/YSort/Player")


func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Elder"
	
	if(player.fireball_given == false):
			#matches the current dialogue state to the dialogue to output
			match dialogue_state:
				0:
					dialogueUI.dialogue = "Ah! Hello there. I see you are out to save us. Please go to the bandit camp to the right."
					dialogueUI.choices = "[E] Uh... Ok. [Q] No thanks."
					dialogue_state = 1
					dialogueUI.open()
					
				1:
					match choice:
						"E":
							dialogueUI.dialogue = "Alright, there you go. There's a spicy gift there."
							dialogueUI.choices = "[Q] Thank you, bye."
							dialogue_state = 3
							dialogueUI.open()
						"Q":
							dialogueUI.dialogue = "Sucks for us... Someday we'll be saved."
							dialogueUI.choices = "[Q] See ya."
							dialogue_state = 3
							dialogueUI.open()
				3:
					dialogue_state = 0
					dialogueUI.close()


	else:
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogueUI.dialogue = "Thanks for taking out those nasty bandits."
				dialogueUI.choices = "[E] No problem."
				dialogueUI.open()
			1:
				dialogueUI.close()
				dialogue_state = 0



