extends AnimatedSprite

var z

func _ready():
	z=self.z_index

func set_value(v):
	self.frame=v
	if v in [0,1,2,18,19]:
		self.z_index=-19
		get_node("../../Navigation2D/"+name).enabled=true
	else:
		self.z_index=z
		get_node("../../Navigation2D/"+name).enabled=false
