extends Sprite

var timer : float = 0

func _process(delta):
	timer+=delta
	while timer>=0.2:
		timer-=0.2
		if self.position.y==0:
			self.position.y=4
		else:
			self.position.y=0
