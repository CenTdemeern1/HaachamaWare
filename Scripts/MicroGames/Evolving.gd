extends MicroGame

var generaltimer = 0
var mashcount = 0
var played_booing_or_success = false
var difficulty

func _ready():
	difficulty = clamp(1+(($"..".difficulty-1)*0.5),1,1.5)
	lifetime/=difficulty
	timer = lifetime
	$Evolve.show()
	$EvolveCancel.hide()
	$Evolve.speed_scale=difficulty
	$EvolveCancel.speed_scale=difficulty
	$Evolve.play()
	$EvolveCancel.play()

func _process(delta):
	generaltimer+=delta
	if generaltimer>=2.0/difficulty and !played_booing_or_success and !preemptively_won_or_lost:
		played_booing_or_success=true
		$Booing.play()
	if generaltimer>0.3/difficulty:
		if generaltimer<2.0/difficulty:
			if Input.is_action_just_pressed("button2"):
				mashcount+=1
				if mashcount == 4:
					win()
					$EvolveCancel.show()
					played_booing_or_success=true
					$Success.play()
