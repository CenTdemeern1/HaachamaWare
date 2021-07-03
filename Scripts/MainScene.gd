extends Control


func _ready():
	modulate=Color(0,0,0)


func _process(delta):
	if !modulate.r>=1:
		modulate=Color(modulate.r+delta*4,modulate.g+delta*4,modulate.b+delta*4)
