extends Node
class_name MicroGame

export var has_timer = true
export(float) var lifetime = 5
var timer = 5
export(int,"Win","Lose") var win_or_lose_on_time_over = 1
var preemptively_won_or_lost = false
export var speed_up_timer = true

func _ready():
	if speed_up_timer:
		lifetime/=$"..".difficulty
	timer = lifetime


func _process(delta):
	if has_timer:
		timer-=delta
		timer = clamp(timer,0,lifetime)
		var frc = timer/lifetime
		$Bomb.frame = int((1-frc)*16)
		if timer == 0:
			time_over()

func time_over():
	if !preemptively_won_or_lost:
		if win_or_lose_on_time_over == 0:
			win_and_end()
		else:
			lose_and_end()
	else:
		end()

func win():
	if !preemptively_won_or_lost:
		$"..".win()
	preemptively_won_or_lost = true

func lose():
	if !preemptively_won_or_lost:
		$"..".penalize()
	preemptively_won_or_lost = true

func win_and_end():
	win()
	end()

func lose_and_end():
	lose()
	end()

func end():
	self.set_process(false)
	$"..".end_minigame()
