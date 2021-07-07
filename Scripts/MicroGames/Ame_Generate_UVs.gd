extends Polygon2D

const quality = 20.0
var points = []
var fuv = []
var speed = 0

func add_point(p):
	self.points.append(p*4)
	self.fuv.append(p)

func _ready():
	self.uv=[]
	for x in range(quality):
		add_point(Vector2(x/quality*108,0))
	add_point(Vector2(108,0))
#	add_point(Vector2(108,120))
	for x in range(quality):
		add_point(Vector2((1-(x/quality))*108,120))
	add_point(Vector2(0,120))
	self.polygon=self.points
	self.uv=self.fuv

func _process(delta):
	speed += 1
	var move = clamp(speed*0.025,0,2)
	var t = $"../Scan".global_position.x
	var y = 0
	for i in range(len(self.points)):
		if self.position.x+self.points[i].x>t:
			self.points[i].x+=move
			y+=1
	assert((y%2)==0)
	self.position.x-=move
	self.polygon=self.points
	$Line2D.points=points
