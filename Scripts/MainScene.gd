extends Node2D

var demotimer = -1
var can_press_start = false
var block_demo = false

func _ready():
	if Global.fadeinMM:
		modulate=Color(0,0,0)


func _process(delta):
	if !modulate.r>=1:
		modulate=Color(clamp(modulate.r+delta*4,0,1),clamp(modulate.g+delta*4,0,1),clamp(modulate.b+delta*4,0,1))
	if !block_demo:
		if can_press_start:
			if demotimer >= 0:
				demotimer+=delta
			else:
				demotimer=delta
		if demotimer >= 30:
			Global.change_scene("res://Scenes/Demo.tscn")
	if Input.is_action_just_pressed("start"):
		start_pressed()

func start_pressed():
	if can_press_start:
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
