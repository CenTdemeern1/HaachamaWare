extends Control

const is_demo = true
var playing_op

func _ready():
	$Pot/Pot/MinigamesPlayed.hide()
	if len(Input.get_connected_joypads()) != 0:
		$OSC.hide()
	playing_op = true
	$OP/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.play("OP")
	var _i = $Pot/Pot/AnimationPlayer.connect("animation_finished",self,"anim_finish")

func anim_finish(name):
	if name=="OP":
		Global.fadeinMM = false
		Global.change_scene("res://Scenes/MainScene.tscn")


#func _process(delta):
#	pass
