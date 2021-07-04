extends Control

var playing_op

func _ready():
	playing_op = true
	$OP/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.connect("animation_finished",self,"anim_finish")

func anim_finish(name):
	if name=="OP":
		$OP.queue_free()
		$Pot/Pot/AnimationPlayer.play("Good")


#func _process(delta):
#	pass
