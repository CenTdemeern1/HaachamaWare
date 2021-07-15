extends MicroGame

const quality = 20
var points = []
var moving_points = quality
var pos = 1
var wait = true
var capture_stage = 0

func _ready():
	$Stretch.hide()
	$BG2.hide()
	$Ame.hide()
	$Scan.hide()
	$OP.show()
	$OP.speed_scale=$"..".difficulty
	$OP.play()
	for _i in range(quality):
		points.append(1.0)

func _process(delta):
	if wait:
		return
	if !capture_stage==1:
		$Scan.position.x-=delta*240*$"..".difficulty
		$BG2.region_rect.size.x=clamp($Scan.position.x/4,0,240)
		$Ame.position.x+=(Input.get_action_strength("right")-Input.get_action_strength("left"))*delta*480*$"..".difficulty
		$Ame.region_rect.size.x=clamp(($Scan.position.x-$Ame.position.x)/4,0,108)
		moving_points=clamp(($Scan.position.x-$Stretch.rect_position.x)/$Stretch.rect_size.x,0,1)*20
		pos=($Scan.position-$Ame.position).x/432
		if $Scan.position.x<$StartScan.position.x and $Scan.position.x>$EndScan.position.x:
			if pos>1:
				lose()
			if pos<0:
				lose()
		for i in range(len(points)):
			if i<moving_points:
				$Stretch.material.set_shader_param("p"+str(i+1),pos)
	if Global.mods["CaptureAme"]:
		if capture_stage==0:
			if $Scan.position.x<$Stretch.rect_position.x:
				var igr = Global.get_instance("res://Scenes/IGRecordViewport.tscn")
				self.add_child(igr)
				var sd = $Stretch
				self.remove_child($Stretch)
				igr.add_child(sd)
#				get_node("IGRecordViewport/Stretch").material.set_shader_param("p10",0.5)
				capture_stage=1
		elif capture_stage==1:
			var image = get_node("IGRecordViewport").get_texture().get_data()
#			image.flip_y()
			image.save_png("user://amestretch.png")
			var s = get_node("IGRecordViewport/Stretch")
			get_node("IGRecordViewport").remove_child(s)
			self.add_child_below_node($BG,s)
			capture_stage=2


func _on_OP_animation_finished():
	$Stretch.show()
	$BG2.show()
	$Ame.show()
	$Scan.show()
	$OP.hide()
	$OP.stop()
	wait = false
