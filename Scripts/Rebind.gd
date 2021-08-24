extends Button
#This code was able to be (largely) sourced from the remapping demo/template project.
#I'm not falsely taking credit for this.
export(String) var action = "ui_up"

func _ready():
	set_process_unhandled_key_input(false)
	display_current_key()

func _toggled(button_pressed):
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		text = "... Key"
		release_focus()
	else:
		display_current_key()


func _unhandled_key_input(event):
	# I'm not using the _input callback because I'm not going to make this work with controllers for now.
	remap_action_to(event)
	pressed = false

func get_first_key_event():
	return Global.get_first_key_event(action)

func remap_action_to(event):
	InputMap.action_erase_event(action,get_first_key_event())
	InputMap.action_add_event(action, event)
	text = "%s Key" % event.as_text()
	Global.save_controls()


func display_current_key():
	#InputMap.get_action_list(action)[action_index]
	var current_key = get_first_key_event().as_text()
	text = "%s Key" % current_key
