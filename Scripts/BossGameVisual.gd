extends "res://Scripts/SpeedUpVisual.gd"

func _process(_delta):
	if visible:
		$"../SpeedUp".visible = false
