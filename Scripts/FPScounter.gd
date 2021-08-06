extends Label

func _process(delta):
	self.text = "FPS: "+str(Performance.get_monitor(Performance.TIME_FPS))
