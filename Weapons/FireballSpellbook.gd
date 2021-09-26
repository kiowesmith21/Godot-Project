extends Area2D

var elder #uses variables from this node
var dialogueUI #will pop up text o show player picked it up
var dialogue_state = 0

func _ready():
	elder = get_tree().root.get_node("/root/World/YSort/Elder")
	dialogueUI = get_tree().root.get_node("/root/World/CanvasLayer/DialogueUI")

func _on_FireballSpellbook_body_entered(body):
	if body.name == "Player":
		talk() #show player picked it up
		elder.spellbook_found = true #set elder spellbook found
	
#Pop up dialogue to tell player picked up item
func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	dialogueUI.npc = self
	dialogueUI.npcname = "Fireball Spellbook"
	
	match dialogue_state:
		0:
			#dialogue
			#setting the npc's state and name to the dialogueUI
			dialogue_state = 1
			dialogueUI.dialogue = "Picked up Fireball Spellbook"
			dialogueUI.choices = "[E] OK"
			dialogueUI.open()
		1:
			get_tree().queue_delete(self) #delete itself from the world
			dialogueUI.close()
