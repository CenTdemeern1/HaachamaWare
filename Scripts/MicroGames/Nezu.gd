extends AnimatedSprite

func _ready():
	speed_scale=$"../..".difficulty
	play("1")


func _on_Nezu_animation_finished():
	if animation=="1":
		play("2")
		$UpRightAltMash.show()
		$"..".mash=true
	elif animation=="2":
		play("3")
		$UpRightAltMash.hide()
		$"..".mash=false
	elif animation=="3":
		play("4")
