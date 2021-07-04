extends AnimationPlayer

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Good":
		play("Bad")
	if anim_name=="Bad":
		play("Good")
