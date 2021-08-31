extends MicroGame

var prev = -1
var pull = 0
var mash = false

func _process(_delta):
	if mash:
		var right = Input.get_action_strength("right")
		var up = Input.get_action_strength("up")
		if right>up and prev!=0:
			prev=0
			pull+=1
		elif right<up and prev!=1:
			prev=1
			pull+=1
		if pull>=6:
			win()
