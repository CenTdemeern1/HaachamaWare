extends MicroGame

var generaltimer = 0
var mashcount = 0

func _ready():
	$Evolve.show()
	$EvolveCancel.hide()
	$Evolve.play()
	$EvolveCancel.play()

func _process(delta):
	generaltimer+=delta
	if generaltimer>0.3:
		if generaltimer<2.0:
			if Input.is_action_just_pressed("button2"):
				mashcount+=1
				if mashcount == 4:
					win()
					$EvolveCancel.show()
