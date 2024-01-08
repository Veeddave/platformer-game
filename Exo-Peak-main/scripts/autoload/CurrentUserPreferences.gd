extends Node
# Create get the UserPreferences
@onready var preferences := UserPreferences.load_or_create()

# get set master volume
@export_range(0, 1, 0.001) var master: float = 1.0 :
	set(value):
		preferences.master = value
		AudioServer.set_bus_volume_db(0, linear_to_db(value))
	get:
		return preferences.master

# get set master volume
@export_range(0, 1, 0.001) var music: float = 1.0 :
	set(value):
		preferences.music = value
		AudioServer.set_bus_volume_db(1, linear_to_db(value))
	get:
		return preferences.music

# get set sfx volume
@export_range(0, 1, 0.001) var sfx: float = 1.0 :
	set(value):
		preferences.sfx = value
		AudioServer.set_bus_volume_db(2, linear_to_db(value))
	get:
		return preferences.sfx

# get set fullscreen toggle
@export var fullscreen: bool = false :
	set(value):
		preferences.fullscreen = value
		if value:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get:
		return preferences.fullscreen

# get set vsync toggle
@export var vsync: bool = false :
	set(value):
		preferences.vsync = value
		if value:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	get:
		return preferences.vsync

# save information
func save():
	preferences.save()

# load values from preferences object
func _ready():
	master = preferences.master
	music = preferences.music
	sfx = preferences.sfx
	fullscreen = preferences.fullscreen
	vsync = preferences.vsync

# toggle fullscreen
func toggle_fullscreen():
	fullscreen = not preferences.fullscreen
