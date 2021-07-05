extends MicroGame

var generaltimer = 0
var mashcount = 0

func _ready():
	$Evolve.show()
	$EvolveCancel.hide()
	$Evolve.speed_scale=$"..".difficulty
	$EvolveCancel.speed_scale=$"..".difficulty
	$Evolve.play()
	$EvolveCancel.play()

func _process(delta):
	generaltimer+=delta
	if generaltimer>0.3/$"..".difficulty:
		if generaltimer<2.0/$"..".difficulty:
			if Input.is_action_just_pressed("button2"):
				mashcount+=1
				if mashcount == 4:
					win()
					$EvolveCancel.show()
