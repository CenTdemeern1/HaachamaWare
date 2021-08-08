extends AnimationPlayer

#var start_minigame_timer = 5
var gameover = false
var gameoverfinished = false
var speedup = false
export var start_minigame = false setget set_start_minigame

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

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="GoodTransition":
		play("Good")
		$"../../..".unload_minigame()
#		start_minigame_timer = 0
		do_speedup()
	if anim_name=="BadTransition":
		$"../../..".unload_minigame()
		if $"../../..".HP==0:
			play("GameOver")
			gameover = true
			self.playback_speed=1
		else:
			play("Bad")
#			start_minigame_timer = 0
		do_speedup()
	if anim_name=="GameOver":
		gameoverfinished=true
