extends CanvasLayer

func _ready():
	$"Settings_Background/Fullscreen/fullscreen".button_pressed = CurrentUserPreferences.fullscreen
	$"Settings_Background/V-sync/vsync".button_pressed = CurrentUserPreferences.vsync

func _on_return_button_pressed():
	if MenuButtons.pmenuButton:
		hide()
	else:
		MenuButtons._on_return_button_pressed()

func _on_fullscreen_toggled(button_pressed):
	CurrentUserPreferences.fullscreen = button_pressed
	CurrentUserPreferences.save()

func _on_vsync_toggled(button_pressed):
	CurrentUserPreferences.vsync = button_pressed
	CurrentUserPreferences.save()

func _on_keybindings_pressed():
	if MenuButtons.pmenuButton:
		$"../Keybindings".show()
	else:
		MenuButtons._on_keybindings_button_pressed()
