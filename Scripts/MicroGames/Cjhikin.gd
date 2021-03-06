extends AnimatedSprite

#TODO: Have the chicken take the highest Z value of the pegs above it, +1, and set it as it's own Z value

const action_timer_max = 1
const action_timer_min = 0.25
const movement_speed = 1.25
const failing_timer_limit = 1.5 #How long a chicken can be out of bounds for until the minigame fails
const movelock = 0.75 #At which point the chicken actively stops rolling random actions to stay out of bounds
var action_timer = 0
var move_direction = Vector2(0,0)
var out_of_bounds_timer = 0 #This timer will be used to check how long a chicken has been out of bounds for, and if it should fail the minigame.

func _ready():
	play()

func _process(delta):
#	var x = $"../Navigation2D".get_simple_path(self.position,get_global_mouse_position())
#	if len(x)>0:
#	self.position = x
#	$"../Line2D".points=x
	do_ai(delta)
	var z = -15
	for peg in $"../../Pegs".get_children():
		if peg.position.y<self.position.y:
			z=max(z,peg.z)
	self.z_index=z+1
	check_safety(delta)

func roll_action():
	if self.action_timer<=0:
		self.action_timer=action_timer_min+(action_timer_max-action_timer_min)*randf()
		generate_move_direction_vector()

func move_relative(delta):
	self.position=$"../../Navigation2D".get_closest_point(self.position+self.move_direction*delta*60*movement_speed)#*$"../..".difficulty

func generate_move_direction_vector():
	self.move_direction=Vector2(randf()*2-1,randf()*2-1).normalized()

func do_ai(delta):
	action_timer-=delta
	if out_of_bounds_timer<movelock:
		roll_action()
	move_relative(delta)
	if move_direction.x>0: # \ The way this is written, it doesn't flip the chicken's facing direction if it's not moving horizontally.
		self.flip_h=true   # |
	if move_direction.x<0: # |
		self.flip_h=false  # /

func check_safety(delta):
	"Checks if the chicken is within the field."
	var centerpoint = $"../../FieldLimitPoint".global_position #I've marked the field center with a Position2D node.
	var offset = self.global_position-centerpoint #Calculate the offset from the center. Used here to normalize the position of the vector (Not the length!)
	offset.x*=0.5 #The field size is double the size horizontally, so I'm compensating for that here.
	if offset.length_squared()>28900: #Equal to length()>170. Inherently more efficient because we're avoiding square roots.
		if self.global_position.y<320: #If the chicken is on the top half of the screen:
			$AlertBottom.show() # \ Show the alert below the chicken
			$AlertBottom.play() # |
			$Alert.hide()       # |
			$Alert.stop()       # /
		else:                   # Else:
			$Alert.show()       # \ Show the alert above the chicken
			$Alert.play()       # |
			$AlertBottom.hide() # |
			$AlertBottom.stop() # /
		out_of_bounds_timer += delta # Add deltaTime to the timer (so the timer counts up in seconds)
		var gb_value = 1-(out_of_bounds_timer/failing_timer_limit) # \ Calculate green and blue values for the next line
		self_modulate = Color(1,gb_value,gb_value,1)               # / Add a visual indicator that makes the chicken redder as time goes on
		if out_of_bounds_timer>=failing_timer_limit: # Is the timer over the limit?
			if !$"../..".has_started_ending: # Have we not yet started the ending sequence?
				$"../..".lose() # Lose if the timer has passed the limit.
	else:
		$Alert.hide()           # \ Stop all alerts
		$AlertBottom.hide()     # |
		$Alert.stop()           # |
		$AlertBottom.stop()     # /
		self_modulate = Color.white # Revert the chicken back to the regular color
