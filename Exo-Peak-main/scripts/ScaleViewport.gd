extends SubViewportContainer

func _ready():
	pivot_offset = size / 2.0
	if get_window().connect("size_changed", _on_screen_resized) != OK:
		print_debug("An error occurred while connecting the screen_resized signal.")
	get_window().min_size = size
	_on_screen_resized()

func _on_screen_resized():
	var new_window_size = DisplayServer.window_get_size()
	
	var scale_w = max(int(new_window_size.x / size.x), 1)
	var scale_h = max(int(new_window_size.y / size.y), 1)
	var the_scale = min(scale_w, scale_h)
	
	scale = Vector2(the_scale, the_scale)



var old_window_mode = null

func _input(event):
	if event.is_action_pressed("fullscreen"):
		CurrentUserPreferences.toggle_fullscreen()
#		if not CurrentUserPreferences.preferences.fullscreen:
#			old_window_mode = DisplayServer.window_get_mode()
#			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
#		elif old_window_mode != null:
#			DisplayServer.window_set_mode(old_window_mode)
#		else:
#			old_window_mode = DisplayServer.window_get_mode()
#			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

