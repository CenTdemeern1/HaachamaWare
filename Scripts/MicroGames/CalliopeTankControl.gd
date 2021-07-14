extends AnimatedSprite

var tank_value : float = 1.0 setget set_tank_value,get_tank_value

func _ready():
	play()

func get_tank_value():
	return tank_value#$Tanks/Tank1.value

func set_tank_value(v:float):
	tank_value = v
	$Tanks/Tank1.value=v
	$Tanks/Tank2.value=v
	$Tanks/Tank3.value=v
	$Tanks/Tank4.value=v

func _process(delta):
	self.tank_value-=delta*0.1
	if frame==0:
		$Tanks.rect_position.y=0
	if frame==1:
		$Tanks.rect_position.y=1
