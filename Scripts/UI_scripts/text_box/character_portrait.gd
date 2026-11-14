extends UI
class_name CharacterPortrait
@onready var name_panel: Panel = $HBoxContainer/name_panel
@onready var name_label: Label = $HBoxContainer/name_panel/name_label
@onready var h_box: HBoxContainer = $HBoxContainer
@onready var portrait_panel: Panel = $HBoxContainer/portrait_panel
@onready var base_pos:Vector2 = position
@onready var port_texture: TextureRect = $HBoxContainer/portrait_panel/portrait_container/TextureRect



signal anim_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	pass # Replace with function body.


func setup():
	modulate.a = 0
	var new_pos = Vector2(base_pos.x,base_pos.y+portrait_panel.size.y)
	position = new_pos
	port_texture.texture = null
	name_label.text = name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hide_character():
	var tween:Tween = create_tween()
	var new_pos = Vector2(base_pos.x,base_pos.y+portrait_panel.size.y)
	var dur:float = 0.3
	tween_visibility(self,false,dur)
	tween.tween_property(self,"position",new_pos,dur)
	await tween.finished
	anim_finished.emit()

func display_character(character:CharacterData):
	set_character(character)
	var tween:Tween = create_tween()
	var new_pos = base_pos
	var dur:float = 0.3
	tween_visibility(self,true,dur/2)
	tween.tween_property(self,"position",new_pos,dur)
	await tween.finished
	anim_finished.emit()


func set_character(character:CharacterData):
	var speaker_name:String = character.name
	if(character.portrait != null):
		portrait_panel.visible = true
		port_texture.texture = character.portrait
	else:portrait_panel.visible = false
	name_panel.tooltip_text = character.description
	if speaker_name != "Game":
		name_label.text = speaker_name
		name_panel.custom_minimum_size.x = (
			speaker_name.length()*name_label.get_theme_font_size("font_size")
			)
