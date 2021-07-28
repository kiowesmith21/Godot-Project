extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self, "_animation_finished") #connect this to the animation finished function as a signal
	frame = 0
	play("Animate")


func _animation_finished():
	queue_free()
