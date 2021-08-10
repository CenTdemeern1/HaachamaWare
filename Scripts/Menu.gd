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
		if not self.svisible: $Buttons/Play.grab_focus()
		self.svisible = true
	if self.svisible:
		v+=(1-v)/4
		if v>0.999:
			v=1
	else:
		v-=v/4
		if v<0.001:
			v=0
	$BlurShader.material.set_shader_param("blur_amount",v*2)
	$BlurShader.modulate=Color(1-v*0.5,1-v*0.5,1-v*0.5,1.0)
	$Buttons.modulate=Color(1,1,1,v)
	self.visible=v!=0

func _input(event):
	if not (event is InputEventKey or event is InputEventJoypadButton): return
	if $SettingsWindow.visible:
		if event.is_action_pressed("tab_backward"):
			get_tree().set_input_as_handled()
			var t = $SettingsWindow/Tabs.current_tab
			t -= 1
			if t == -1: t += $SettingsWindow/Tabs.get_child_count()
			$SettingsWindow/Tabs.current_tab = t
			_on_Tabs_tab_changed(t)
		elif event.is_action_pressed("tab_forward"):
			get_tree().set_input_as_handled()
			var t = $SettingsWindow/Tabs.current_tab
			t = (t+1) % $SettingsWindow/Tabs.get_child_count()
			$SettingsWindow/Tabs.current_tab = t
			_on_Tabs_tab_changed(t)
		

func _on_Settings_pressed():
	self.accept_event()
	$SettingsWindow.show()
	$SettingsWindow/Tabs.current_tab = 0
	$SettingsWindow/Tabs/Settings/VBoxContainer/Fullscreen.grab_focus()


func _on_Play_pressed():
	self.svisible = false
	$SettingsWindow.hide()
	$"..".start_pressed()


func _on_Exit_pressed():
	self.accept_event()
	get_tree().quit()


func _on_Tabs_tab_changed(tab):
	if tab == 0:
		$SettingsWindow/Tabs/Settings/VBoxContainer/Fullscreen.grab_focus()
	elif tab == 1:
		$SettingsWindow/Tabs/Mods/VBoxContainer/InvControls.grab_focus()
