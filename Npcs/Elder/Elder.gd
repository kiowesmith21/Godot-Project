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
var choice = 0
var dialogueUI
var player

func _ready():
	dialogueUI = get_parent().get_parent().get_node("GameUI/DialogueUI2")
	player = get_parent().get_parent().get_node("Player/Player")

func talk(dialogue_state):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Elder"
	
	if(quest_status == QuestStatus.NOT_STARTED):
			#matches the current dialogue state to the dialogue to output
			match choice:
				0:
					choice = 1
					dialogueUI.dialogue = "Ah! Hello there. We need you to retrieve the spellbook from the bandit camp."
					dialogueUI.choices = "[E] Uh... Ok. [Q] No thanks."
					dialogueUI.open()
					yield(get_tree().create_timer(10), "timeout")
				1:
					
					match dialogue_state:
						0:
							choice = 2
							dialogueUI.dialogue = "Alright, there you go. Watch out for those bandits randomly popping up in the forest."
							dialogueUI.choices = "[Q] Thank you, bye."
							dialogueUI.open()
						1:
							choice = 3
							dialogueUI.dialogue = "You won't beat the alpha then."
							dialogueUI.choices = "[E] Whatever."
							dialogueUI.open()
				2:
					choice = 0
					dialogueUI.close()
					player.talkingStat = false
					quest_status = QuestStatus.STARTED
				3:
					choice = 0
					player.talkingStat = false
					dialogueUI.close()
			yield(get_tree().create_timer(3), "timeout")

	elif(quest_status == QuestStatus.STARTED):
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogueUI.dialogue = "Go defeat those bandits already!"
				dialogueUI.choices = "[Q] I forgot what to do, thanks."
				dialogueUI.open()
			1:
				dialogueUI.close()
				player.talkingStat = false
				dialogue_state = 0
		yield(get_tree().create_timer(3), "timeout")
	else:
		match dialogue_state:
			0:
				dialogue_state = 1
				dialogueUI.dialogue = "The alpha is done! Thanks for playing."
				dialogueUI.choices = "[Q] Bye then."
				dialogueUI.open()
			1:
				dialogueUI.close()
				player.talkingStat = false
				dialogue_state = 0
		yield(get_tree().create_timer(3), "timeout")
	yield(get_tree().create_timer(3), "timeout")



