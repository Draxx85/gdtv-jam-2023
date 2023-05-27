extends Control

@onready var tree : SceneTree = get_tree()
@onready var pause_screen : Control = $PauseScreen
@onready var photo_screen : Control = $PhotoScreen
@onready var active_screen : EActiveScreen = EActiveScreen.none

enum EActiveScreen {pause_menu, photo_menu, none}

func _process(delta):
	if Input.is_action_just_pressed("gameMenu"):
		if Globals.is_paused():
			if (active_screen == EActiveScreen.pause_menu):
				Globals.unpause_game.emit()
				_on_unpause()
			else:
				_on_pause()
		else:
			Globals.pause_game.emit()
			_on_pause()
	if Input.is_action_just_pressed("photoMenu"):
		if Globals.is_paused():
			if (active_screen == EActiveScreen.photo_menu):
				Globals.unpause_game.emit()
				_on_photo_menu_close()
			else:
				_on_photo_menu()
		else:
			Globals.pause_game.emit()
			_on_photo_menu()

func _on_pause() -> void:
	active_screen = EActiveScreen.pause_menu
	pause_screen.show()
	photo_screen.hide()
	
func _on_unpause() -> void:
	active_screen = EActiveScreen.none
	pause_screen.hide()

func _on_photo_menu():
	active_screen = EActiveScreen.photo_menu
	photo_screen.show()
	pause_screen.hide()
	
func _on_photo_menu_close():
	active_screen = EActiveScreen.none
	photo_screen.hide()
