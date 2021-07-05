extends "res://Scripts/AutoPlayAnimatedSprite.gd"

var timer = -1

func show_su():
	self.show()
	timer=0

func _process(delta):
	if timer>=0:
		timer+=delta
		if timer>1.5:
			self.hide()
			timer=-1
