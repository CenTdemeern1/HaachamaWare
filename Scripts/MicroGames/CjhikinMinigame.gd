extends MicroGame

var has_started_ending = false
var ending_timer = 0

var rotvalue = 0.0

func _ready():
	pass

func absrange(num, mi, ma):
	while num<mi:
		num+=ma-mi
	while num>ma:
		num-=ma-mi
	return num

func _process(delta):
	if has_started_ending:
		ending_timer+=delta
	
	if Input.is_action_pressed("up") or Input.is_action_pressed("right"):
		rotvalue+=delta
	if Input.is_action_pressed("down") or Input.is_action_pressed("left"):
		rotvalue-=delta
	rotvalue = absrange(rotvalue,0,1)
	var f = round(rotvalue*20) as int
#	$BG.frame=f
#	$FG.frame=f
#	$Label.text=str(f)
#	for peg in range(1,23):
#		var p : NavigationPolygonInstance = get_node("Navigation2D/Peg"+str(peg))
#		p.enabled=false
#		for i in range(pegdata[f][0],pegdata[f][1]+1):
#			if absrange(i,0,22)==peg-1:
#				p.enabled=true
	for peg in range(1,23):
		var p = get_node("Pegs/Peg"+str(peg))
		var x = (f-peg)
		if peg==1:
			x-=1
		while x<0:
			x+=20
		p.set_value(x)

func win_and_end():
	if has_started_ending:
		if ending_timer>=1:
			win()
			end()
	else:
		has_started_ending=true
		$Kiara.play("Intro")

func _on_Kiara_animation_finished():
	$Kiara.play("Loop")
