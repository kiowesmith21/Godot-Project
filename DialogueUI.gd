extends Popup

var npcname setget name_set
var dialogue setget dialogue_set
var choices setget choices_set
var npc

func name_set(new_value):
	npcname = new_value
	$ColorRect/NPCName.text = new_value
	
func dialogue_set(new_value):
	dialogue = new_value
	$ColorRect/Dialogue.text = new_value
	
func choices_set(new_value):
	choices = new_value
	$ColorRect/Choices.text = new_value


func open():
	get_tree().paused = true
	popup()
	$AnimationPlayer.playback_speed = 60.0 / dialogue.length()
	$AnimationPlayer.play("ShowDialogue")

	
func close():
	get_tree().paused = false
	hide()
	

func _ready():
	set_process_input(false)

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("interact"):
		set_process_input(false)
		npc.talk("E")
	elif event.is_action_pressed("cancel"):
		set_process_input(false)
		npc.talk("Q")
