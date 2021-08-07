extends Label

func _process(_delta):
	var successful_cuts=$"..".successful_cuts
	var current_vegetable=0
	if successful_cuts>=8:
		current_vegetable=1
	if successful_cuts>=16:
		current_vegetable=2
	if successful_cuts>=22:
		current_vegetable=3
	self.text="0"+str(clamp(3-current_vegetable,0,INF))
