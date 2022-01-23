extends Sprite

var cursor_pointing_at = 3

func _ready():
	$Cursor.play()
	$SymbolIndicatorSprite.frame = randi()%8
	var keys = get_children()
	keys.erase($SymbolIndicatorSprite)
	while keys!=[]:
		var key = keys[randi()%len(keys)]
		key.frame=len(keys)-1
		keys.erase(key)

func _process(_delta):
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
		if pressed_key.frame == $SymbolIndicatorSprite.frame:
			$"..".win()
