extends AnimationPlayer
#
#func _ready():
#	play("OP")
#
#
#func _on_AnimationPlayer_animation_finished(anim_name):
#	Global.change_scene("res://Scenes/Pot.tscn")

var skiptimer = 0
var dont_affect = false

func set_speed(spd):
	self.playback_speed=spd
	$"../../Pot/Pot/AnimationPlayer".playback_speed=spd
	$"../AudioStreamPlayer".pitch_scale=spd

func _process(delta):
	if $"../..".playing_op:
		if !$"..".visible:
			pass
		elif Input.is_action_pressed("button1") or Input.is_action_pressed("start"):
			skiptimer+=delta
		else:
			skiptimer-=delta
		skiptimer=clamp(skiptimer,0,1)
		$"../Skip/SkipProgress".value = skiptimer
		$"../Skip".visible = skiptimer != 0
		if skiptimer==1:
			set_speed(8)
		else:
			set_speed(1)
	elif !dont_affect:
		dont_affect = true
		set_speed(1)
