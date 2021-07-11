extends Node2D

export var action = ""
export var inverted_action = ""

func _process(_delta):
	if Global.mods["InvControls"]:
		$Button.action=inverted_action
	else:
		$Button.action=action
