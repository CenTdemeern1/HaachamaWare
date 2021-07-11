extends Node

var resource_queue
var fadeinMM = true
var mods = {
	InvControls=false,
	InvColors=false,
	LTW=false,
	Distraction=false
}
var controls_are_inverted : bool = false

func change_scene(to):
	var _i = get_tree().change_scene_to(resource_queue.get_resource(to))

func get_instance(name):
	return resource_queue.get_resource(name).instance()

func _process(_delta):
	#RNG scrambling.
	#TAS-able. (RNG derived only from timing and user input)
	advance_RNG()
	for action in InputMap.get_actions():
		if Input.is_action_pressed(action):
			advance_RNG(3)

func advance_RNG(a=null):
	if a==null:
		a=1
	for _i in range(a):
		var _r = randi()

func invert_controls():
	var up = InputMap.get_action_list("up")
	var down = InputMap.get_action_list("down")
	var left = InputMap.get_action_list("left")
	var right = InputMap.get_action_list("right")
	var a = InputMap.get_action_list("button1")
	var b = InputMap.get_action_list("button2")
	InputMap.action_erase_events("up")
	InputMap.action_erase_events("down")
	InputMap.action_erase_events("left")
	InputMap.action_erase_events("right")
	InputMap.action_erase_events("button1")
	InputMap.action_erase_events("button2")
	for ac in up: InputMap.action_add_event("down",ac)
	for ac in down: InputMap.action_add_event("up",ac)
	for ac in left: InputMap.action_add_event("right",ac)
	for ac in right: InputMap.action_add_event("left",ac)
	for ac in a: InputMap.action_add_event("button2",ac)
	for ac in b: InputMap.action_add_event("button1",ac)

func set_controls_inverted(a:bool):
	if !a == controls_are_inverted:
		controls_are_inverted = a
		invert_controls()

func set_fullscreen(v):
	OS.window_fullscreen=v

func toggle_fullscreen():
	OS.window_fullscreen=!OS.window_fullscreen
