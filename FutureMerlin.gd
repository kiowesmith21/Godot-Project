extends KinematicBody2D

enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED

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
	
	if(quest_status == QuestStatus.NOT_STARTED):
			#matches the current dialogue state to the dialogue to output
			match dialogue_state:
				0:
					dialogue_state = 1
					dialogueUI.dialogue = "Well hello you must be Merlin Jr. Nice to meet you. I’m also Merlin Jr. I’m on a quest of my own, so there’s no time to be confused. Try to keep up, yeah? I’m here from the future to let you know how your life will turn out. You’ll kill your friends, your childhood heroes, and even your father. Shall we get started? "
					dialogueUI.choices = "[E] Do I really have a choice?"
					dialogueUI.open()
				1:
					match choice:
						"E":
							dialogue_state = 2
							dialogueUI.dialogue = "Ha! Of course not. Now go find the elders so we can get started."
							dialogueUI.choices = "[Q] Well alright, I guess."
							dialogueUI.open()
					
				2:
					dialogue_state = 0
					dialogueUI.close()
					quest_status = QuestStatus.STARTED
