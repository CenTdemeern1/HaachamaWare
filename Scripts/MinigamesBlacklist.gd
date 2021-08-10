extends Control

func translate_file_to_minigame_name(s:String):
	return s.replace("res://Scenes/MicroGames/","").replace(".tscn","")

func _ready():
	for i in Global.minigames:
		$HBoxContainer/ActiveMinigames.add_item(translate_file_to_minigame_name(i))
	for i in Global.disabled_minigames:
		$HBoxContainer/InactiveMinigames.add_item(translate_file_to_minigame_name(i))

func _input(event):
	if not (event is InputEventKey): return
	if event.is_action_pressed("left") and get_focus_owner() == $HBoxContainer/ActiveMinigames:
		_on_MoveLeft_pressed(true)
	if event.is_action_pressed("right") and get_focus_owner() == $HBoxContainer/InactiveMinigames:
		_on_MoveRight_pressed(true)

func _on_MoveLeft_pressed(e=false):
	var selections = $HBoxContainer/ActiveMinigames.get_selected_items()
	if (selections as Array)==[]:
		if not e: get_tree().get_root().get_children()[-1].get_node("Menu/NG").play()
	else:
		get_tree().get_root().get_children()[-1].get_node("Menu/OK2").play()
	selections.invert()
	for i in selections:
		Global.disabled_minigames.append(Global.minigames[i])
		$HBoxContainer/InactiveMinigames.add_item(translate_file_to_minigame_name(Global.minigames[i]))
		Global.minigames.remove(i)
		$HBoxContainer/ActiveMinigames.remove_item(i)

func _on_MoveRight_pressed(e=false):
	var selections = $HBoxContainer/InactiveMinigames.get_selected_items()
	if (selections as Array)==[]:
		if not e: get_tree().get_root().get_children()[-1].get_node("Menu/NG").play()
	else:
		get_tree().get_root().get_children()[-1].get_node("Menu/OK2").play()
	selections.invert()
	for i in selections:
		Global.minigames.append(Global.disabled_minigames[i])
		$HBoxContainer/ActiveMinigames.add_item(translate_file_to_minigame_name(Global.disabled_minigames[i]))
		Global.disabled_minigames.remove(i)
		$HBoxContainer/InactiveMinigames.remove_item(i)
