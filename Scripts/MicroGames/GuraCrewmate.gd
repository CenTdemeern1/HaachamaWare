extends AnimatedSprite

#And it's name is...
#SharkBot.

const action_timer_max = 2
const action_timer_min = 0.25
const movement_speed = 2
var action_timer = 0
enum actions {
	idle
	move
	dying
	dead
	exit
}
var action = actions.idle
var choosable_actions = [actions.idle,actions.move]
enum {
	left
	right
}
var direction = left
var move_direction = Vector2(0,0)

func roll_action():
	if self.action_timer<=0:
		self.action=choosable_actions[randi()%len(choosable_actions)]
		self.action_timer=action_timer_min+(action_timer_max-action_timer_min)*randf()
		if self.action==actions.move:
			generate_move_direction_vector()

func move_relative(delta):
	self.position=$"../Floor".get_closest_point(self.position+self.move_direction*delta*60*movement_speed*$"../..".difficulty)

func generate_move_direction_vector():
	self.move_direction=Vector2(randf()*2-1,randf()*2-1).normalized()

func _ready():
	roll_action()

func make_an_exit():
	self.action_timer=20
	self.action=actions.exit
	$"../Floor/NavigationPolygonInstance2".enabled=true

func _process(delta):
	action_timer-=delta
	if self.action==actions.dying:
		self.move_direction*=0.75
		move_relative(delta)
		return
	if self.action==actions.dead:
		return
	if self.action==actions.move:
		move_relative(delta)
		if move_direction.x>0:
			self.direction=right
		if move_direction.x<0:
			self.direction=left
	if self.action==actions.exit:
		self.move_direction=($"../Exit".position-self.position).normalized()
		move_relative(delta*2)
		if move_direction.x>0:
			self.direction=right
		if move_direction.x<0:
			self.direction=left
	if self.direction==left:
		self.play("WalkLeft")
	if self.direction==right:
		self.play("WalkRight")
	if self.action==actions.idle:
		self.playing=false
		self.frame=0
	else:
		self.playing=true
	roll_action()

func die():
	self.action=actions.dying
	if self.animation=="WalkLeft":
		self.play("DieLeft")
	if self.animation=="WalkRight":
		self.play("DieRight")

func _on_GuraCrewmate_animation_finished():
	if self.animation=="DieLeft" or self.animation=="DieRight":
		self.action=actions.dead
		self.play("Dead")
