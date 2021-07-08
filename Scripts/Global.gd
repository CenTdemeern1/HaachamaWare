extends Node

var resource_queue
var fadeinMM = true
var mods = {
	InvControls=false,
	InvColors=false,
	LTW=false
}

func change_scene(to):
	get_tree().change_scene_to(resource_queue.get_resource(to))

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
	for i in range(a):
		randi()
