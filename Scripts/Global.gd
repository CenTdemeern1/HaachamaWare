extends Node

var resource_queue
var fadeinMM = true

func change_scene(to):
	get_tree().change_scene_to(resource_queue.get_resource(to))
