extends MicroGame

func _ready():
#	print("init")
	$GuraLaugh.hide()
	$Gura.show()

func _process(_delta):
	if !$Crosshair.shot:
		if timer <= 0.5:
			$Miss.show()
			$Miss.play("Single")
			$Crosshair.shot=true

func hit():
#	print("hit!")
	win()
	$Hit.play()
	$GuraLaugh.show()
	$GuraLaugh.play()
	$Gura.hide()

func miss():
#	print("miss!")
	lose()
	$Miss.show()
	$Miss.play("Single")


func _on_Hit_animation_finished():
	$Hit.stop()
	$Hit.frame=3


func _on_Miss_animation_finished():
	$Miss.play("Loop")
#	$Miss.stop()
#	$Miss.frame=13
