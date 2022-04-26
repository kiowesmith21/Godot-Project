extends Label

var drawTextSpeed:int = 0 
var chatterLimit:int = 450

func _ready():
	pass # Replace with function body.
func _showChatter():
	if drawTextSpeed < chatterLimit:
		drawTextSpeed += 1
		self.visible_characters = drawTextSpeed
	pass
func _process(delta):
	_showChatter()
	pass

