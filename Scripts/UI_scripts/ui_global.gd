extends Node

@onready var dark_screen:ColorRect = ColorRect.new()

@onready var song_player:AudioStreamPlayer = AudioStreamPlayer.new()


const button_hover_sfx_path:String = "res://Assets/UI_assets/button_hover_sfx_example.ogg"
const button_click_sfx_path:String = "res://Assets/UI_assets/sbutton_click_sfx_example.ogg"

var button_hover_sfx_stream:AudioStream = preload(button_hover_sfx_path)
var button_click_sfx_stream:AudioStream = preload(button_click_sfx_path)

@onready var button_hover_sfx:AudioStreamPlayer = AudioStreamPlayer.new()
@onready var button_click_sfx:AudioStreamPlayer = AudioStreamPlayer.new()

const button_hover_sfx_db:float = -10
const button_click_sfx_db:float = -10

var menu_songs_path:Dictionary[String,String] = {
	"MainMenu":"",
	"Credits":""
}

var audio_value:Dictionary[StringName,int] = {
	"SFX": 50,
	"Music": 50,
	"UI": 50,
	"Global": 50
}

func _ready() -> void:
	init_dark_screen()
	init_button_sfx()
	init_song_player()

func init_dark_screen():
	dark_screen.color = Color.BLACK
	#sets the anchor to the full screen
	dark_screen.anchor_bottom = 1
	dark_screen.anchor_right = 1
	dark_screen.anchor_top = 0
	dark_screen.anchor_left = 0
	dark_screen.z_index = 500
	get_tree().root.add_child.call_deferred(dark_screen)
	if(get_tree().current_scene is not MenuUI):
		dark_screen.modulate.a = 0
		dark_screen.visible = false
		

func init_button_sfx():
	button_hover_sfx.bus = "sfx"
	button_click_sfx.bus = "sfx"
	button_hover_sfx.stream = button_hover_sfx_stream
	button_click_sfx.stream = button_click_sfx_stream
	button_hover_sfx.volume_db = button_hover_sfx_db
	button_click_sfx.volume_db = button_click_sfx_db
	get_tree().root.add_child.call_deferred(button_click_sfx)
	get_tree().root.add_child.call_deferred(button_hover_sfx)

func init_song_player():
	song_player.bus = "music"
	get_tree().root.add_child.call_deferred(song_player)


func switch_scenes(new_scene_path:String):
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	var new_scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	get_tree().current_scene = current_scene
