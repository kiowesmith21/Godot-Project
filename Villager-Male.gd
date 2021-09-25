extends AnimatedSprite


var dialogue_state = 0

var dialogueUI
var player

func _ready():
	dialogueUI = get_tree().root.get_node("/root/World/CanvasLayer/DialogueUI")
	player = get_tree().root.get_node("/root/World/YSort/Player")


func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Villager"

	#matches the current dialogue state to the dialogue to output
	match dialogue_state:
		0:
			dialogueUI.dialogue = "Oh my goodnes, I hate these bandits. Thank goodness you are the only one to save us."
			dialogueUI.choices = "[Q] I guess I am."
			dialogue_state = 1
			dialogueUI.open()
					
		1:
			dialogue_state = 0
			dialogueUI.close()
