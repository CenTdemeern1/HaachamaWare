extends MicroGame

var count_endtimer = false
var endtimer = 0

func _process(delta):
	if count_endtimer:
		endtimer+=delta
		if endtimer>=1:
			end()
#	if timer <= 1 and !preemptively_won_or_lost:

func time_over():
	if preemptively_won_or_lost:
		if !count_endtimer:
			end()
	else:
		lose()
		count_endtimer = true
		$SuiseiImpostor.set_process(false)
		$SuiseiImpostor.playing=false
		$SuiseiImpostor.frame=0
		$AnimationPlayer.playback_speed=$"..".difficulty
		$AnimationPlayer.play("Lose")
