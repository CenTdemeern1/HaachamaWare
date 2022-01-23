extends Sprite

var cursor_pointing_at = 3
var has_selected_a_key = false

func _ready():
	$Cursor.play()
	$SymbolIndicatorSprite.frame = randi()%8
	var keys = get_children()
	keys.erase($SymbolIndicatorSprite)
	keys.erase($Cursor)
	while keys!=[]:
		var key = keys[randi()%len(keys)]
		key.frame=len(keys)-1
		keys.erase(key)

func _process(_delta):
	if has_selected_a_key:
		return
	if Input.is_action_just_pressed("left"):
		if $Cursor.position.x>26:
			$Cursor.position.x-=21
			cursor_pointing_at-=1
	if Input.is_action_just_pressed("right"):
		if $Cursor.position.x<173:
			$Cursor.position.x+=21
			cursor_pointing_at+=1
	if Input.is_action_just_pressed("button1"):
		var pressed_key = get_child(cursor_pointing_at)
		var keyframe = pressed_key.frame
		if pressed_key.frame == $SymbolIndicatorSprite.frame:
			$"..".win()
			pressed_key.animation = "Good"
		else:
			pressed_key.animation = "Bad"
		pressed_key.frame = keyframe
		$Cursor.hide()
		has_selected_a_key = true
