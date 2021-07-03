extends Node

export var has_timer = true
export var lifetime = 5
var timer = 5

func _ready():
	timer = lifetime


func _process(delta):
	if has_timer:
		timer-=delta
