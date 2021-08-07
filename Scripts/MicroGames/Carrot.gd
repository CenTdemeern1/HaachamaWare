extends Node2D

var next_piece = 0
export var veggie_index = 0
#var correct_button_just_pressed

func _process(_delta):
	visible=$"..".current_vegetable==veggie_index
#		correct_button_just_pressed=$"..".correct_button_just_pressed
#	if $"..".correct_button_just_pressed:
#		if self.next_piece>=get_child_count():
#			reset()

func increment():
	if name=="Eggplant":
		if self.next_piece==0:
			pass
#			self.position.x-=36
		elif self.next_piece==1:
			self.position.x-=20
		elif self.next_piece==2:
			self.position.x-=12
		else:
			self.position.x-=8
	else:
		if self.next_piece==0:
			self.position.x-=4
		elif self.next_piece>=5:
			self.position.x-=12
		else:
			self.position.x-=8
	self.next_piece+=1

func reset():
	self.next_piece=0
	self.position.x=504
	for i in get_children():
		i.reset()
