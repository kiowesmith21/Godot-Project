extends ColorRect

#var fireball_given = get_tree().root.get_node("/root/World/YSort/Player").fireball_given
#add a signal to create a function that turns the visibility of sprite three from off to on

signal wpn_changed

func _ready():
	$Skill1.color = Color(1,1,0,.25)
	$Skill2.color = Color(0,0,0,.25)
	$Skill3.color = Color(0,0,0,.25)
	$Skill3/Fireball.hide()
	var wpn_choice = $"/root/World/Player/Player/PlayerStats".curr_wpn
	pass
	
func _input(delta):
	if (Input.get_action_strength("choose_weapon_1")):
		$Skill1.color = Color(1,1,0,.25)
		$Skill2.color = Color(0,0,0,.25)
		$Skill3.color = Color(0,0,0,.25)
	elif(Input.get_action_strength("choose_weapon_2")):
		$Skill2.color = Color(1,1,0,.25)
		$Skill1.color = Color(0,0,0,.25)
		$Skill3.color = Color(0,0,0,.25)
	elif(Input.get_action_strength("choose_weapon_3")):
		$Skill3.color = Color(1,1,0,.25)
		$Skill2.color = Color(0,0,0,.25)
		$Skill1.color = Color(0,0,0,.25)
