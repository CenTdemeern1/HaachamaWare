extends Node2D

var next_piece = 0

func _process(_delta):
	if $"..".correct_button_just_pressed:
		if self.next_piece>=get_child_count():
			reset()

func increment():
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
