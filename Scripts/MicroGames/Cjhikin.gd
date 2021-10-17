extends AnimatedSprite

#TODO: Have the chicken take the highest Z value of the pegs above it, +1, and set it as it's own Z value

func _process(delta):
#	var x = $"../Navigation2D".get_simple_path(self.position,get_global_mouse_position())
	var x = $"../Navigation2D".get_closest_point(get_global_mouse_position())
#	if len(x)>0:
	self.position = x
#	$"../Line2D".points=x
