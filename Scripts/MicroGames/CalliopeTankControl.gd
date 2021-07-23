extends AnimatedSprite

var tank_value : float = 1.0 setget set_tank_value,get_tank_value
var goal = 1.0
var won = false

func win():
	$"..".win()
	$"../SpeechBubbles/Guh".show()
	$"../SpeechBubbles/Zzz".hide()
	won = true

func lose_if_lost():
	if won:
		play("Guh")
	else:
		play("Zzz")

func _ready():
	play("drink")

func get_tank_value():
	return tank_value#$Tanks/Tank1.value

func set_tank_value(v:float):
	tank_value = v
	var tanks = $Tanks.get_children()
	for tank in tanks:
		tank.value=round(tank_value*tank.rect_size.y)/tank.rect_size.y

func _process(_delta):
	if Input.is_action_just_pressed("button1") and self.animation=="drink" and goal>0.1:
#		print("beep!",self.tank_value)
		goal -= 0.2*$"../..".difficulty
		if goal<=0.1:
			goal=0
			win()
	self.tank_value-=(self.tank_value-goal)*.25
	if frame==0:
		$Tanks.rect_position.y=0
	if frame==1:
		$Tanks.rect_position.y=1

func _on_Calliope_animation_finished():
	if animation=="Zzz":
		play("ZzzLoop")
	if animation=="Guh":
		play("GuhLoop")
