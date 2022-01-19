extends AnimatedSprite

var count_endtimer = false
var endtimer = 0

func _ready():
	self.play("default")

func _process(delta):
	if count_endtimer:
		endtimer+=delta
		if endtimer>=0.65: #650ms like in the animation
			$"..".lose()
			$"..".end()
			count_endtimer = false

func _on_AnimatedBombScene_animation_finished():
	if self.animation=="explode":
		$"../frame_off".show()
		$"../frame".hide()
		count_endtimer = true
