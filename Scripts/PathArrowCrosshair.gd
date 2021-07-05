extends PathFollow2D

var total_timer = 0
var pause = 0.5

func _process(delta):
	total_timer+=delta/2
	if total_timer<0.75:
		unit_offset = total_timer
	elif total_timer<=0.75+pause:
		unit_offset=0.75
	else:
		unit_offset=total_timer-pause
