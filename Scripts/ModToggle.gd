extends CheckBox

func _ready():
	self.pressed=Global.mods[self.name]

func _toggled(button_pressed):
	Global.mods[self.name]=button_pressed
	Global.save_controls()
