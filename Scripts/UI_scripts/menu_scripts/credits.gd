extends MenuUI
@onready var return_button: Button = $Panel/MarginContainer/MarginContainer/return_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.buttons = [return_button]
	connect_buttons()
	self.setup_UI()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_button_pressed() -> void:
	self.handle_scene_transition("res://Scenes/UI_scenes/menu_scenes/main_menue.tscn")
	pass # Replace with function body.
