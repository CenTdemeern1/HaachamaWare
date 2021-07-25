extends Node2D

var demotimer = -1
var can_press_start = false
var block_demo = false

func _ready():
	if Global.fadeinMM:
		modulate=Color(0,0,0)
	Global.set_controls_inverted(false)


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

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and !$Menu.svisible:
			if event.position.x>$LogoTL.global_position.x and event.position.y>$LogoTL.global_position.y and event.position.x<$LogoBR.global_position.x and event.position.y<$LogoBR.global_position.y:
				start_pressed()
			else:
				$Menu.svisible=true

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
	if len(Global.minigames)>0:
		Global.change_scene("res://Scenes/Game.tscn")
	else:
		Global.change_scene("res://Scenes/Demo.tscn")
