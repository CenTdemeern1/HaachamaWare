extends AnimatedSprite

func _ready():
	play("Intro")

#func _process(_delta):
#	if !self.playing:
#		play("Loop")


func _on_AnimatedSprite_animation_finished():
	play("Loop")
