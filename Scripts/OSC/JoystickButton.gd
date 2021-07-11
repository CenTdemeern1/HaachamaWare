extends TouchScreenButton

#This script serves to redirect input events to the node's parent, which will process them
func _input(event):
	$"..".process_child_input(event)
