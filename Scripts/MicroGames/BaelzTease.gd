extends MicroGame

var prev = -1
var pull = 0
var mash = false
var mashamount = 6

func _ready():
	mashamount=floor(float(mashamount)/$"..".difficulty)

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
		if pull>=mashamount and !preemptively_won_or_lost:
			win()
			$Nezu.play("3")
			$Nezu/UpRightAltMash.hide()
			mash=false
