class_name PlayerSave extends Resource

@export var health: int = 8
@export var position := Vector2(104, 100)
@export var lastCheckpoint := Vector2(104, 100)
@export var level_num: int = 1
func save():
	ResourceSaver.save(self, "res://resources/player_Save.tres")

static func load_or_create() -> PlayerSave:
	var res: PlayerSave = load("res://resources/player_Save.tres") as PlayerSave
	if !res:
		res = PlayerSave.new()
	return res



