extends AnimatedSprite

var tank_value : float = 1.0 setget set_tank_value,get_tank_value
var goal = 1.0

func _ready():
	play()

func get_tank_value():
	return tank_value#$Tanks/Tank1.value

func set_tank_value(v:float):
	tank_value = v
	var tanks = $Tanks.get_children()
	for tank in tanks:
		tank.value=round(tank_value*tank.rect_size.y)/tank.rect_size.y

func _process(delta):
	if Input.is_action_just_pressed("button1"):
#		print("beep!",self.tank_value)
		goal -= 0.1
	self.tank_value-=(self.tank_value-goal)*.25
	if frame==0:
		$Tanks.rect_position.y=0
	if frame==1:
		$Tanks.rect_position.y=1
