extends Control
class_name UI

@export var click_sfx:AudioStreamPlayer
@export var hover_sfx:AudioStreamPlayer
@export var song:AudioStreamPlayer

@export var dark_screen:ColorRect
var buttons:Array[Button] = []
signal vis_changed

##Sets the game to unpaused, lightens the screen and turns song on
func enter_trans():
	if get_tree().paused: get_tree().paused = false
	lighten_screen()
	song_on(song)

##Connects the buttons to on_mouse_entered, on_mouse_exited && base_button_pressed 
##global function. These functions handle sound and Shrink / Expand effects
func connect_buttons(dur:float = 0.2,scale_size:float = 1.3):
	for button in buttons:
		button.mouse_entered.connect(button_mouse_entered.bind(button,scale_size,dur))
		button.mouse_exited.connect(button_mouse_exited.bind(button,dur))
		button.pressed.connect(base_button_pressed)


func base_button_pressed():
	assert(click_sfx != null)
	click_sfx.play()
	pass

##Expands the button's scale and plays the hover SFX
func button_mouse_entered(button:Button,scale_size:float,dur:float):
	var enlarge:bool = true
	tween_scale(enlarge,button,dur,scale_size)
	assert(hover_sfx != null)
	hover_sfx.play()
	pass

##Shrinks the button to its default size
func button_mouse_exited(button:Button,dur:float):
	var enlarge:bool = false
	tween_scale(enlarge,button,dur)
	pass

##Turns the screen dark by tweening the visibility of the dark_screen ColorRect
func darken_screen(dur:float = 0.4):
	assert(dark_screen != null)
	tween_visibility(dark_screen,true,dur)

##Turns lightens the screen by tweening the visibility of the dark_screen ColorRect
func lighten_screen(dur:float = 0.4):
	assert(dark_screen != null)
	tween_visibility(dark_screen,false,dur)
	
signal volume_changed
##Tweens the given Music's Linear volume to the given Value
func tween_music(val:float,music:AudioStreamPlayer = song,dur:float = 0.4):
	assert(music != null)
	var tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(music,"volume_linear",val,dur)
	await tween.finished
	volume_changed.emit()
	volume_changed.emit.call_deferred()

##Changes the visibility of the given node by tweening it's Alpha value
##then changes the visibile variable to the given Boolean
func tween_visibility(node:Control,to_visible:bool,dur:float = 0.3):
	var tween = create_tween()
	var target_color:Color
	node.visible = true
	if to_visible:
		node.modulate.a = 0
		target_color = Color(1,1,1,1)
	else: 
		node.modulate.a = 1
		target_color = Color(1,1,1,0)
	tween.tween_property(node,"modulate",target_color,dur)
	await tween.finished
	vis_changed.emit()
	node.visible = to_visible
	

func tween_scale(enlarge:bool,node:Control,dur:float = 0.2,to_scale:float = 1.3):
	node.pivot_offset = node.size/2
	var tween = create_tween()
	if !enlarge: to_scale = 1
	tween.tween_property(node,"scale",to_scale*Vector2.ONE,dur)

##Tweens the given song to silence, then turns it off
func song_off(music:AudioStreamPlayer = song,dur:float = 0.6):
	tween_music(db_to_linear(-80),music,dur)
	await volume_changed
	music.playing = false

##plays the given song and tweens the song's DB from silence to the given DB 
func song_on(music:AudioStreamPlayer = song,db_val:float = -15,dur:float = 5):
	music.volume_linear = db_to_linear(-80)
	music.playing = true
	music.play()
	tween_music(db_to_linear(db_val),music,dur)

##Darkens the screen, turns the song off, and switches to the given scene
func handle_scene_transition(next_scene:String):
	var dur:float = 0.3
	darken_screen(dur)
	song_off(song,dur)
	await volume_changed
	UI_GLOBAL.switch_scenes(next_scene)
	
