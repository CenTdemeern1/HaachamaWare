extends ColorRect

func _process(_delta):
	if Input.is_action_pressed("button1"):
		var c = self.material.get_shader_param("blur_amount")
		var r = c+(2-c)/4
		self.material.set_shader_param("blur_amount",r)
		self.modulate=Color(1-r/4,1-r/4,1-r/4,1.0)
	visible=self.material.get_shader_param("blur_amount")!=0

