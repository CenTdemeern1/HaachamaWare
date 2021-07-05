extends Node

var resource_queue
var fadeinMM = true

func change_scene(to):
	get_tree().change_scene_to(resource_queue.get_resource(to))

func get_instance(name):
	return resource_queue.get_resource(name).instance()
