extends MicroGame

var quicktime = false

func _ready():
	$AnimationPlayer.play("OP")
	$AnimationPlayer.playback_speed=$"..".difficulty
	$Ame.speed_scale=$"..".difficulty

func _process(_delta):
	if quicktime:
		if Input.is_action_just_pressed("down"):
			$AnimationPlayer.play("GP")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="OP":
		$AnimationPlayer.play("Quicktime")
		quicktime = true
	if anim_name=="Quicktime":
		quicktime = false
		$AnimationPlayer.play("Lose")
	if anim_name=="GP":
		win_and_end()
	if anim_name=="Lose":
		lose_and_end()
