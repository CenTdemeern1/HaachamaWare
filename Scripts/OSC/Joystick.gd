extends Node2D

func _ready():
	self.visible=OS.has_touchscreen_ui_hint()

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			move_by_event(event)
			do_action_based_on_stick()
		else:
			if event.position.x<480:
				$JS.position=Vector2.ZERO
				do_action_based_on_stick()
	if event is InputEventScreenDrag:
		move_by_event(event)
		do_action_based_on_stick()

func move_by_event(event):
	if event.position.x>$topleft.global_position.x and event.position.y>$topleft.global_position.y and event.position.x<$bottomright.global_position.x and event.position.y<$bottomright.global_position.y:
		var rel = (event.position-self.position)
		$JS.position=rel.normalized()*clamp(rel.length(),0,100)
#	else:
#		$JS.position=Vector2.ZERO

func do_action_based_on_stick():
	Input.action_release("up")
	Input.action_release("down")
	Input.action_release("left")
	Input.action_release("right")
	var strength = ($JS.position/100).abs()
	if $JS.position.x>0:
		if Global.mods["InvControls"]:
			Input.action_press("left",strength.x)
		else:
			Input.action_press("right",strength.x)
	if $JS.position.x<0:
		if Global.mods["InvControls"]:
			Input.action_press("right",strength.x)
		else:
			Input.action_press("left",strength.x)
	if $JS.position.y>0:
		if Global.mods["InvControls"]:
			Input.action_press("up",strength.y)
		else:
			Input.action_press("down",strength.y)
	if $JS.position.y<0:
		if Global.mods["InvControls"]:
			Input.action_press("down",strength.y)
		else:
			Input.action_press("up",strength.y)
