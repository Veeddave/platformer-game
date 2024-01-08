class_name UserPreferences extends Resource

@export_range(0, 1, 0.001) var master: float = 1.0
@export_range(0, 1, 0.001) var music: float = 1.0
@export_range(0, 1, 0.001) var sfx: float = 1.0

@export var fullscreen: bool = false
@export var vsync: bool = false
@export var actionEvents: Dictionary = {}

func save():
	ResourceSaver.save(self, "res://resources/user_preferences.tres")

static func load_or_create() -> UserPreferences:
	var res: UserPreferences = load("res://resources/user_preferences.tres") as UserPreferences
	if !res:
		res = UserPreferences.new()
	return res
  
