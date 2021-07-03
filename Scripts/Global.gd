extends Node

var resource_queue

func change_scene(to):
	get_tree().change_scene_to(resource_queue.get_resource(to))
