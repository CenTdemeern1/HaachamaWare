extends Node2D

func _process(_delta):
	if !$"../../..".is_demo:
		$StomachCure1.visible = $"../../..".HP >= 4
		$StomachCure2.visible = $"../../..".HP >= 3
		$StomachCure3.visible = $"../../..".HP >= 2
		$StomachCure4.visible = $"../../..".HP >= 1
