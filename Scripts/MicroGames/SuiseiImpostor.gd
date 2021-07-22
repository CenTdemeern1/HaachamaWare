extends AnimatedSprite

const movement_speed = 2.5
enum actions {
	idle
	move
}
var action = actions.idle
var choosable_actions = [actions.idle,actions.move]
enum {
	left
	right
}
var direction = left
var move_direction = Vector2(0,0)

var can_kill = false

func move_relative(delta):
	self.position=$"../Floor".get_closest_point(self.position+self.move_direction*delta*60*movement_speed)

func _process(delta):
	self.move_direction=Vector2(Input.get_action_strength("right")-Input.get_action_strength("left"),Input.get_action_strength("down")-Input.get_action_strength("up"))
	if self.move_direction == Vector2.ZERO:
		self.action=actions.idle
	else:
		self.action=actions.move
	if self.action==actions.move:
		move_relative(delta)
		if move_direction.x>0:
			self.direction=right
		if move_direction.x<0:
			self.direction=left
	if self.direction==left:
		self.flip_h = false
	if self.direction==right:
		self.flip_h = true
	if self.action==actions.idle:
		self.playing=false
		self.frame=0
	else:
		self.playing=true
	if self.position.y<$"../GuraCrewmate".position.y:
		self.z_index=-1
	else:
		self.z_index=0
	if can_kill:
		if $"../GuraCrewmate".action!=$"../GuraCrewmate".actions.dead and $"../GuraCrewmate".action!=$"../GuraCrewmate".actions.dying:
			$"../Kill".color=Color(0.7,0,0,1)
			if Input.is_action_just_pressed("button1"):
				$"../GuraCrewmate".die()
				self.position=$"../GuraCrewmate".position
	else:
		$"../Kill".color=Color.black

func _on_Area2D_area_entered(area):
	self.can_kill=true

func _on_Area2D_area_exited(area):
	self.can_kill=false
