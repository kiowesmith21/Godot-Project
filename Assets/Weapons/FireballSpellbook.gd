extends Area2D

var player #uses variables from this node
var dialogueUI #will pop up text to show player picked it up
var skillbar #used to tell the skillbar to show the fireball skill
var dialogue_state = 0
#2285.02, 1007.48

func _ready():
	dialogueUI = get_parent().get_parent().get_node("GameUI/DialogueUI")#get_tree().root.get_node("/root/World/CanvasLayer/DialogueUI")
	player = get_parent().get_parent().get_node("Player/Player")
	skillbar = get_parent().get_parent().get_node("GameUI/Skillbar")
	

func _on_FireballSpellbook_body_entered(body):
	if body.name == "Player":
		talk() #show player picked it up
		skillbar.get_child(2).get_child(0).show()
		
	
#Pop up dialogue to tell player picked up item
func talk(choice = ""):
	#setting the npc's state and name to the dialogueUI
	if(is_instance_valid(dialogueUI)):
		print_debug("DialogueUI is true")
		
		dialogueUI.npc = self
		dialogueUI.npcname = "Fireball Spellbook"
	else:
		print_debug("Dialogue is false")
	
	
	match dialogue_state:
		0:
			#dialogue
			#setting the npc's state and name to the dialogueUI
			dialogue_state = 1
			dialogueUI.dialogue = "Picked up Fireball Spellbooddk"
			dialogueUI.choices = "[E] OK"
			player.fireball_given = true
			dialogueUI.open()
		1:
			get_tree().queue_delete(self) #delete itself from the world
			dialogueUI.close()
