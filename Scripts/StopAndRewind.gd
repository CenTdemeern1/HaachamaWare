extends AnimatedSprite

export var rewindTo = 0
export var autoplay = true

func _ready():
	var _i = connect("animation_finished",self,"finish")
	if autoplay:
		play()

func finish():
	stop()
	frame=rewindTo
