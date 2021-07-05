extends AnimationPlayer

var start_minigame_timer = 5

func _process(delta):
	if start_minigame_timer<3:
		start_minigame_timer+=delta
		if start_minigame_timer>=3:
			$"../../..".start_minigame()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="GoodTransition":
		play("Good")
		$"../../..".unload_minigame()
		start_minigame_timer = 0
	if anim_name=="BadTransition":
		play("Bad")
		$"../../..".unload_minigame()
		start_minigame_timer = 0
