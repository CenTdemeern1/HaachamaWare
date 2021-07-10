extends Control

const is_demo = false
var playing_op
var HP = 4
var speed = 1 setget set_speed
var difficulty = 1# setget set_difficulty
var minigames_played = 0
var won = true
#var initial_start_minigame_timer = 16
var minigames = [
	"res://Scenes/MicroGames/FishinGura.tscn",
	"res://Scenes/MicroGames/Evolving.tscn",
	"res://Scenes/MicroGames/LongWatson.tscn",
	"res://Scenes/MicroGames/WarioAme.tscn"
	]
var goal_timer = 0

func set_speed(x):
	speed=x
	difficulty=pow(speed,0.33)#sqrt(speed)
#func set_difficulty(x):
#	difficulty=x
#	speed=difficulty*difficulty

func _ready():
	playing_op = true
	$OP/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.connect("animation_finished",self,"anim_finish")
#	initial_start_minigame_timer = 0
	if Global.mods["Distraction"]:
		self.add_child(Global.get_instance("res://Scenes/Distraction.tscn"))
	if Global.mods["InvColors"]:
		self.add_child(Global.get_instance("res://Scenes/ColorInvert.tscn"))
	if Global.mods["InvControls"]:
		Global.set_controls_inverted(true)

func anim_finish(name):
	if name=="OP":
		$OP.queue_free()
		playing_op = false
#		$Pot/Pot/AnimationPlayer.play("Good")

func win():
	if Global.mods["LTW"]:
		_penalize()
	else:
		_win()

func penalize():
	if Global.mods["LTW"]:
		_win()
	else:
		_penalize()

func _win():
	won = true

func _penalize():
	HP-=1
	won=false

func end_minigame():
	if won:
		$Pot/Pot/AnimationPlayer.play("GoodTransition")
	else:
		$Pot/Pot/AnimationPlayer.play("BadTransition")
	increment_minigames_played()

func increment_minigames_played():
	minigames_played+=1
	if fmod(minigames_played,2.5)<=0.5:
		self.speed += 1 #Speed up!!!
		$Pot/Pot/AnimationPlayer.speedup=true

func start_minigame():
	var mg = Global.get_instance(minigames[randi()%len(minigames)])
	self.add_child_below_node($MinigameGoesHere,mg)
	$Goal.text=mg.goal
	goal_timer=0.4
	$Goal.show()

func unload_minigame():
	var minigames = get_tree().get_nodes_in_group("Minigame")
	assert(len(minigames)==1)
	minigames[0].queue_free()

func _process(delta):
	if goal_timer>0:
		var x = clamp(goal_timer*10,2,4)
		$Goal.rect_scale=Vector2(x,x)
		goal_timer-=delta
	$Goal.visible=goal_timer>0
#	if initial_start_minigame_timer<15.3:
#		initial_start_minigame_timer+=delta
#		if initial_start_minigame_timer>=15.3:
#			start_minigame()
