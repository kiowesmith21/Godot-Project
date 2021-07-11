extends KinematicBody2D

#Quests
#Starting Quest
#player has to get stolen spellbook from bandits
#will receive fireball as reward
enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED
var spellbook_found = false

var dialogue_state = 0
var fireball_given = false

var dialogueUI
var player

func _ready():
	dialogueUI = get_tree().root.get_node("/root/World/CanvasLayer/DialogueUI")
	player = get_tree().root.get_node("/root/World/YSort/Player")


func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Elder"
	
	if(fireball_given == false):
			#matches the current dialogue state to the dialogue to output
			match dialogue_state:
				0:
					dialogue_state = 1
					dialogueUI.dialogue = "Ah! Hello there. I see you are out to save us. Here, have some magic."
					dialogueUI.choices = " [E] Uh... Ok. [Q] No thanks."
					dialogueUI.open()
					
				1:
					match choice:
						"E":
							dialogue_state = 2
							dialogueUI.dialogue = "Alright, there you go. Don't go burning down the town."
							dialogueUI.choices = "[E] Thank you, bye."
							dialogueUI.open()
						"Q":
							dialogue_state = 3
							dialogueUI.dialogue = "Sucks for you. See you."
							dialogueUI.choices = "[E] See ya."
							dialogueUI.open()
				2:
					dialogueUI.close()
					dialogue_state = 3
					player.fireball_given = true
					fireball_given = true

					
				3:
					dialogueUI.close()
					dialogue_state = 0

	else:
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogueUI.dialogue = "I already gave you magic! Go save our town!"
				dialogueUI.choices = "[E] Bye then."
				dialogueUI.open()
			1:
				dialogueUI.close()
				dialogue_state = 0



