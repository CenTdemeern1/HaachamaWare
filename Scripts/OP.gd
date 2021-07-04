extends AnimationPlayer

func _ready():
	play("OP")


func _on_AnimationPlayer_animation_finished(anim_name):
	Global.change_scene("res://Scenes/Pot.tscn")
