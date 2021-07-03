extends Node2D

var can_press_start = false

func _ready():
	modulate=Color(0,0,0)


func _process(delta):
	if !modulate.r>=1:
		modulate=Color(modulate.r+delta*4,modulate.g+delta*4,modulate.b+delta*4)
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
	Global.change_scene("res://Scenes/OP.tscn")
