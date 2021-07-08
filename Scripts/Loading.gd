extends Control

const things_to_load = [
	"res://Scenes/OP.tscn",
	"res://Scenes/Pot.tscn",
	"res://Scenes/Game.tscn",
	"res://Scenes/Demo.tscn",
	"res://Scenes/ColorInvert.tscn",
	"res://Scenes/MicroGames/FishinGura.tscn",
	"res://Scenes/MicroGames/Evolving.tscn",
	"res://Scenes/MicroGames/LongWatson.tscn"
	]

func _ready():
	Global.resource_queue = preload("res://Scripts/resource_queue.gd").new()
	Global.resource_queue.start()
	for i in things_to_load:
		Global.resource_queue.queue_resource(i)
	Global.resource_queue.queue_resource("res://Scenes/MainScene.tscn") #load it last


func _process(delta):
	if len(Global.resource_queue.queue)==0:#is_ready("res://Scenes/MainScene.tscn")
		#I can't just set a grayscale value so I have to do this :(
		modulate=Color(modulate.r-delta,modulate.g-delta,modulate.b-delta)
		if modulate.r <= 0:
			Global.change_scene("res://Scenes/MainScene.tscn")
