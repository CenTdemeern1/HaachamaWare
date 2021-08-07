extends Label

func _process(_delta):
	self.text = "FPS: "+str(Performance.get_monitor(Performance.TIME_FPS))
