extends Control

const things_to_load = [
	"res://Assets/Sprites/Clear.aseprite",
	"res://Assets/Audio/GAME_CLEAR.mp3",
	"res://Assets/Audio/BOSS.mp3",
	"res://Scenes/OP.tscn",
	"res://Scenes/OSC.tscn",
	"res://Scenes/Pot.tscn",
	"res://Scenes/Game.tscn",
	"res://Scenes/Demo.tscn",
	"res://Scenes/ColorInvert.tscn",
	"res://Scenes/Distraction.tscn",
	"res://Scenes/IGRecordViewport.tscn",
	"res://Scenes/MicroGames/FishinGura.tscn",
	"res://Scenes/MicroGames/Evolving.tscn",
	"res://Scenes/MicroGames/LongWatson.tscn",
	"res://Scenes/MicroGames/WarioAme.tscn",
	"res://Scenes/MicroGames/CalliDrink.tscn",
	"res://Scenes/MicroGames/SuiseiAmongUs.tscn",
	"res://Scenes/MicroGames/Boss.tscn"
	]

func _ready():
	Global.resource_queue = preload("res://Scripts/resource_queue.gd").new()
	if OS.get_name()!="HTML5":
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
