extends Label
var drawTextSpeed:int = 0 

var chatterLimit: int = 56

func _ready():
	pass # Replace with function body.
func _showChatter():
	if drawTextSpeed chatterLimit:
		drawTextSpeed += 1 
		self.visible_characters = drawTextSpeed
		
		pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
