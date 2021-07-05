extends AnimatedSprite

export var rewindTo = 0

func _ready():
	connect("animation_finished",self,"finish")
	play()

func finish():
	stop()
	frame=rewindTo
