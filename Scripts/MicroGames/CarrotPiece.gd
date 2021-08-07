extends Sprite

const grv : float = 9.8

var initial_position

export var goes_in_pot = false
var falling = false
var velocity = Vector2.ZERO
var has_been_above_pot = false

func _ready():
	initial_position=position

func reset():
	falling = false
	position = initial_position
	velocity = Vector2.ZERO
	has_been_above_pot = false
	self.show()

func increment_cp():
	$"..".increment()

func _process(delta):
	if falling or !self.visible or $"..".veggie_index!=$"../..".current_vegetable:
		pass
	elif $"../..".correct_button_just_pressed and $"..".get_children()[$"..".next_piece]==self:
		if goes_in_pot:
			velocity = Vector2(-7.5,-40)
		else:
			velocity = Vector2(-7.5,-7.5)
		falling = true
		call_deferred("increment_cp")
	if falling:
#		print(velocity)
		self.position += velocity * delta * 20
		velocity.y += grv * delta * 20
		if goes_in_pot:
			if self.global_position.y<$"../../Pot".position.y:
				has_been_above_pot = true
			if has_been_above_pot and self.global_position.y>$"../../Pot".position.y:
				self.hide()
				self.falling=false
				$"../../Pot/AnimationPlayer".play("bob_down")
