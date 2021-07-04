extends Node2D

var demotimer = -1
var can_press_start = false

func _ready():
	if Global.fadeinMM:
		modulate=Color(0,0,0)


func _process(delta):
	if !modulate.r>=1:
		modulate=Color(modulate.r+delta*4,modulate.g+delta*4,modulate.b+delta*4)
	if demotimer >= 0:
		demotimer+=delta
	else:
		if can_press_start:
			demotimer=delta
	if demotimer >= 30:
		Global.change_scene("res://Scenes/Demo.tscn")
	if can_press_start:
		if Input.is_action_just_pressed("start"):
			can_press_start=false
			$BGM.stop()
			$Start.play()
			$StartAnim.show()
			$StartAnim.play()


func _on_LogoDrop_finished():
	$BGM.play()
	can_press_start = true


func _on_Start_finished():
	Global.change_scene("res://Scenes/Game.tscn")
