extends Control

func translate_file_to_minigame_name(s:String):
	return s.replace("res://Scenes/MicroGames/","").replace(".tscn","")

func _ready():
	for i in Global.minigames:
		$ActiveMinigames.add_item(translate_file_to_minigame_name(i))
	for i in Global.disabled_minigames:
		$InactiveMinigames.add_item(translate_file_to_minigame_name(i))

#func _process(_delta):
#	pass

func _on_MoveLeft_pressed():
	var selections = $ActiveMinigames.get_selected_items()
	if (selections as Array)==[]:
		$"../../../../NG".play()
	else:
		$"../../../../OK2".play()
	selections.invert()
	for i in selections:
		Global.disabled_minigames.append(Global.minigames[i])
		$InactiveMinigames.add_item(translate_file_to_minigame_name(Global.minigames[i]))
		Global.minigames.remove(i)
		$ActiveMinigames.remove_item(i)
	Global.save_controls()

func _on_MoveRight_pressed():
	var selections = $InactiveMinigames.get_selected_items()
	if (selections as Array)==[]:
		$"../../../../NG".play()
	else:
		$"../../../../OK2".play()
	selections.invert()
	for i in selections:
		Global.minigames.append(Global.disabled_minigames[i])
		$ActiveMinigames.add_item(translate_file_to_minigame_name(Global.disabled_minigames[i]))
		Global.disabled_minigames.remove(i)
		$InactiveMinigames.remove_item(i)
	Global.save_controls()
