extends MicroGame

func lose_and_end():
	$AnimatedBombScene.play("explode")


func _on_Bomb_animation_finished():
	$Bomb.hide()
