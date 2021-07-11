extends ColorRect

signal wpn_changed

func _ready():
	var wpn_choice = $"/root/PlayerStats".curr_wpn
	pass
	
func _input(delta):
	if (Input.get_action_strength("choose_weapon_1")):
		$Skill1.color = Color(1,1,0,.25)
		$Skill2.color = Color(0,0,0,.25)
		$Skill3.color = Color(0,0,0,.25)
		$Skill4.color = Color(0,0,0,.25)
	elif(Input.get_action_strength("choose_weapon_2")):
		$Skill2.color = Color(1,1,0,.25)
		$Skill1.color = Color(0,0,0,.25)
		$Skill3.color = Color(0,0,0,.25)
		$Skill4.color = Color(0,0,0,.25)
	elif(Input.get_action_strength("choose_weapon_3")):
		$Skill3.color = Color(1,1,0,.25)
		$Skill2.color = Color(0,0,0,.25)
		$Skill1.color = Color(0,0,0,.25)
		$Skill4.color = Color(0,0,0,.25)
	elif(Input.get_action_strength("choose_weapon_4")):
		$Skill4.color = Color(1,1,0,.25)
		$Skill2.color = Color(0,0,0,.25)
		$Skill3.color = Color(0,0,0,.25)
		$Skill1.color = Color(0,0,0,.25)
