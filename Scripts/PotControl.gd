extends AnimationPlayer

#var start_minigame_timer = 5
var gameclear
var gameclearaudio
var bosswarning
var good1
var bad1
var gameover = false
var gameoverfinished = false
var speedup = false
export var start_minigame = false setget set_start_minigame

func _ready():
	gameclear = Global.resource_queue.get_resource("res://Assets/Sprites/Clear.aseprite")
	gameclearaudio = Global.resource_queue.get_resource("res://Assets/Audio/GAME_CLEAR.mp3")
	bosswarning = Global.resource_queue.get_resource("res://Assets/Audio/BOSS.mp3")
	good1 = $"../Good1".stream
	bad1 = $"../Bad1".stream

func set_start_minigame(v):
	if v:
		if !$"../../..".is_demo:
			$"../../..".start_minigame()

func _process(_delta):
	if gameoverfinished:
		if Input.is_action_just_pressed("button1") or Input.is_action_just_pressed("button2") or Input.is_action_just_pressed("start"):
			Global.change_scene("res://Scenes/MainScene.tscn")
#	if start_minigame_timer<3:
#		start_minigame_timer+=delta
#		if start_minigame_timer>=3:
#			$"../../..".start_minigame()

func do_speedup():
	if speedup:
		speedup=false
		$"../SpeedUp".show_su()
	if $"../../..".minigames_played > 0 and ($"../../..".minigames_played%20)==0 and Global.disabled_minigames==[]:
		$"../BossGame".show_su()

func swap_out_sfx():
	return
#	if $"../../..".minigames_played > 0 and ($"../../..".minigames_played%20)==0 and Global.disabled_minigames==[]:
#		$"../Good1".stream=bosswarning
#		$"../Bad1".stream=bosswarning
#	else:
#		$"../Good1".stream=good1
#		$"../Bad1".stream=bad1

func _on_AnimationPlayer_animation_finished(anim_name):
	swap_out_sfx()
	if anim_name=="GoodTransition":
		if $"../../..".minigames_played > 0 and ($"../../..".minigames_played%20)==0 and Global.disabled_minigames==[]:
			play("GoodBOSS")
		else:
			play("Good")
		$"../../..".unload_minigame()
#		start_minigame_timer = 0
		do_speedup()
	if anim_name=="BadTransition":
		$"../../..".unload_minigame()
		if $"../../..".HP==0:
			if $"../../..".won_boss:
				$"../GameOver".frames=gameclear
				$"../GameOver".scale=Vector2(2,2)
				$"../GameOverSFX".stream=gameclearaudio
			play("GameOver")
			gameover = true
			self.playback_speed=1
		else:
			if $"../../..".minigames_played > 0 and ($"../../..".minigames_played%20)==0 and Global.disabled_minigames==[]:
				play("BadBOSS")
			else:
				play("Bad")
#			start_minigame_timer = 0
		do_speedup()
	if anim_name=="GameOver":
		gameoverfinished=true
