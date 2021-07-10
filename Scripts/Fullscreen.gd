extends CheckButton

func _ready():
	self.pressed=OS.window_fullscreen

func _toggled(button_pressed):
	Global.set_fullscreen(button_pressed)
