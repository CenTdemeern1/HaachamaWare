extends Control

var v : float = 0.0
var svisible = false

#func _ready():
#	self.hide()

func _process(_delta):
	#The following code is hanging on by a thread, for unknown reasons...
	#Might be some weird jank
	#I think I figured out the jank...
	#Forgot to clamp the parent's fade in color modulate
	if self.svisible and Input.is_action_just_pressed("button2"):
		self.svisible = false
		$SettingsWindow.hide()
	elif Input.is_action_just_pressed("button1") or Input.is_action_just_pressed("button2") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		self.svisible = true
	if self.svisible:
		$"..".block_demo=true
		v+=(1-v)/4
		if v>0.999:
			v=1
	else:
		$"..".block_demo=false
		v-=v/4
		if v<0.001:
			v=0
	$BlurShader.material.set_shader_param("blur_amount",v*2)
	$BlurShader.modulate=Color(1-v*0.5,1-v*0.5,1-v*0.5,1.0)
	$Buttons.modulate=Color(1,1,1,v)
	self.visible=v!=0


func _on_Settings_pressed():
	$SettingsWindow.popup()


func _on_Play_pressed():
	self.svisible = false
	$SettingsWindow.hide()
	$"..".start_pressed()


func _on_Exit_pressed():
	get_tree().quit()
