extends MicroGame

var buttons = ["up","down","left","right","button1","button2"]
var sprites = [
	preload("res://Assets/Sprites/minigame/Boss/Indicators/DpadDirectionsYellow3.png"),
	preload("res://Assets/Sprites/minigame/Boss/Indicators/DpadDirectionsYellow1.png"),
	preload("res://Assets/Sprites/minigame/Boss/Indicators/DpadDirectionsYellow2.png"),
	preload("res://Assets/Sprites/minigame/Boss/Indicators/DpadDirectionsYellow4.png"),
	preload("res://Assets/Sprites/minigame/Boss/Indicators/AButton.png"),
	preload("res://Assets/Sprites/minigame/Boss/Indicators/BButton.png")
	]

var correct_button_just_pressed = false
var anything_pressed = false
var successful_cuts = 0
var current_button_queue
var next_button_queue
var current_vegetable = 0

func shift_over_queue():
	current_button_queue=next_button_queue
	var i = randi()%len(buttons)
	next_button_queue=buttons[i]
	$Banner/Indicator1.texture=$Banner/Indicator2.texture
	$Banner/Indicator2.texture=sprites[i]

func _ready():
	shift_over_queue()
	shift_over_queue()

func _process(_delta):
	correct_button_just_pressed=false
	if !anything_pressed:
		var correct_button_pressed = false
		for button in buttons:
			if Input.is_action_pressed(button):
				anything_pressed=true
				if button==current_button_queue:
					correct_button_just_pressed=true
					shift_over_queue()
					if successful_cuts>=8:
						current_vegetable=1
					if successful_cuts>=16:
						current_vegetable=2
					if successful_cuts>=22:
						current_vegetable=3
#					current_vegetable=int(floor(successful_cuts/8))
					successful_cuts+=1
#					print(current_vegetable)
					$Haachama.show()
					$HaachamaDisgusted.hide()
					$CutSFX.play()
					correct_button_pressed = true
					if successful_cuts == 22:
						win()
		if anything_pressed and !correct_button_pressed:
			$Haachama.hide()
			$HaachamaDisgusted.show()
	else:
		anything_pressed=false
		for button in buttons:
			if Input.is_action_pressed(button):
				anything_pressed=true
