extends Node2D

var rotvalue = 0.0

func _ready():
	pass

var pegdata = [
	[-2,3],
	[-1,4],
	[0,5],
	[1,6],
	[2,7],
	[3,8],
	[4,9],
	[5,10],
	[6,12],
	[7,13],
	[8,14],
	[9,15],
	[10,16],
	[11,17],
	[13,18],
	[14,19],
	[15,20],
	[16,21],
	[-5,0],
	[-4,1],
	[-3,2],
]

func absrange(num, mi, ma):
	while num<mi:
		num+=ma-mi
	while num>ma:
		num-=ma-mi
	return num

func _process(delta):
	if Input.is_action_pressed("up"):
		rotvalue+=delta
	if Input.is_action_pressed("down"):
		rotvalue-=delta
	rotvalue = absrange(rotvalue,0,1)
	var f = round(rotvalue*20) as int
	$BG.frame=f
	$FG.frame=f
	$Label.text=str(f)
	for peg in range(1,23):
		var p : NavigationPolygonInstance = get_node("Navigation2D/Peg"+str(peg))
		p.enabled=false
		for i in range(pegdata[f][0],pegdata[f][1]+1):
			if absrange(i,0,22)==peg-1:
				p.enabled=true
	
