extends MicroGame

func _ready():
	$AnimationPlayer.playback_speed=$"..".difficulty
	$Calliope.speed_scale=$"..".difficulty
	$ButtonHint.speed_scale=$"..".difficulty
	$AnimationPlayer.play("default")


