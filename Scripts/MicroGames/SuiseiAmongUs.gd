extends MicroGame

func _process(_delta):
	if timer <= 1 and !preemptively_won_or_lost:
		lose()
		$SuiseiImpostor.set_process(false)
		$AnimationPlayer.playback_speed=$"..".difficulty
		$AnimationPlayer.play("Lose")
