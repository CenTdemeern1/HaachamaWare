extends AnimatedSprite

var shot = false

func _ready():
	position=$"../ReferenceRect".rect_position+$"../ReferenceRect".rect_size*Vector2(randf(),randf())


func _process(delta):
	if !shot:
		if Input.is_action_just_pressed("button1"):
			shot=true
			self.play()
	if !shot:
		position.x+=(Input.get_action_strength("right")-Input.get_action_strength("left"))*delta*480
		position.y+=(Input.get_action_strength("down")-Input.get_action_strength("up"))*delta*480
		var clamprect : Rect2 = $"../ReferenceRect".get_rect()
		position.x = clamp(position.x,clamprect.position.x,clamprect.position.x+clamprect.size.x)
		position.y = clamp(position.y,clamprect.position.y,clamprect.position.y+clamprect.size.y)


func _on_Crosshair_animation_finished():
	stop()
	hide()
#	$RayCast2D.force_raycast_update()
#	if $RayCast2D.is_colliding():
	if $"../Hitbox".get_rect().has_point(self.position):
		$"..".hit()
	else:
		$"..".miss()
