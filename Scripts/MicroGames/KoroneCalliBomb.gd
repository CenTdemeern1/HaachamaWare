extends MicroGame

var has_started_exploding = false

func lose_and_end():
	if !has_started_exploding:
		$AnimatedBombScene.play("explode_start")
		has_started_exploding = true


func _on_Bomb_animation_finished():
	$Bomb.hide()
