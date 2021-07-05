extends Control

const is_demo = false
var playing_op
var HP = 4
var won = true
var initial_start_minigame_timer = 16
var minigames = ["res://Scenes/MicroGames/FishinGura.tscn"]

func _ready():
	playing_op = true
	$OP/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.play("OP")
	$Pot/Pot/AnimationPlayer.connect("animation_finished",self,"anim_finish")
	initial_start_minigame_timer = 0

func anim_finish(name):
	if name=="OP":
		$OP.queue_free()
		playing_op = false
#		$Pot/Pot/AnimationPlayer.play("Good")

func win():
	won = true

func penalize():
	HP-=1
	won=false

func end_minigame():
	if won:
		$Pot/Pot/AnimationPlayer.play("GoodTransition")
	else:
		$Pot/Pot/AnimationPlayer.play("BadTransition")

func start_minigame():
	self.add_child_below_node($MinigameGoesHere,Global.get_instance(minigames[randi()%len(minigames)]))

func unload_minigame():
	var minigames = get_tree().get_nodes_in_group("Minigame")
	assert(len(minigames)==1)
	minigames[0].queue_free()

func _process(delta):
	if initial_start_minigame_timer<15.3:
		initial_start_minigame_timer+=delta
		if initial_start_minigame_timer>=15.3:
			start_minigame()
