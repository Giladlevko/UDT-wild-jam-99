extends MenuUI
@onready var play_button: Button = $Panel/MarginContainer/VBoxContainer/buttons_container/play_button
@onready var audio_button: Button = $Panel/MarginContainer/VBoxContainer/buttons_container/audio_button
@onready var credits_button: Button = $Panel/MarginContainer/VBoxContainer/buttons_container/credits_button
@onready var quit_button: Button = $Panel/MarginContainer/VBoxContainer/buttons_container/quit_button
@onready var help_button: Button = $Panel/MarginContainer/help_button_container/help_button

@onready var controls_panel: Panel = $Panel/MarginContainer/contols_cont/MarginContainer/controls_panel

@onready var audio_controler: AUDIO_CONTROLER = $Panel/MarginContainer/audio_controler


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.setup_UI()
	buttons = [play_button,audio_button,credits_button,quit_button,help_button]
	self.connect_buttons()
	setup_audio_controller()
	pass # Replace with function body.

func setup_audio_controller():
	audio_controler.hover_sfx = self.hover_sfx
	audio_controler.click_sfx = self.click_sfx

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	pass # Replace with function body.


func _on_audio_button_pressed() -> void:
	self.tween_visibility(audio_controler,true)
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	self.handle_scene_transition("res://Scenes/UI_scenes/menu_scenes/credits.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	self.darken_screen()
	await vis_changed
	get_tree().quit()
	pass # Replace with function body.


func _on_help_button_pressed() -> void:
	var to_vis:bool = !controls_panel.visible
	tween_visibility(controls_panel,to_vis)
	pass # Replace with function body.
