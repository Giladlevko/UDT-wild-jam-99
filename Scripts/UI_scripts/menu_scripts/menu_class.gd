extends UI
class_name MenuUI

##Lightens the screen, sets the dark screen and the button SFX to their UI_Global counterparts
func setup_UI():
	self.dark_screen = UI_GLOBAL.dark_screen
	self.click_sfx = UI_GLOBAL.button_click_sfx
	self.hover_sfx = UI_GLOBAL.button_hover_sfx
	self.song = UI_GLOBAL.song_player
	#after self vars are ready enter trans
	self.enter_trans()
	
