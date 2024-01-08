extends Node
# stores locational values
var pSave: PlayerSave

# location where player spawns in first level
var spawnerLocation = Vector2(104, 100):
	set(value):
		pSave.position = value
	get:
		return pSave.position
		
# players current location
var level_num = 1:
	set(value):
		pSave.level_num = value
	get:
		return pSave.level_num

# players health value
var health = 8:
	set(value):
		pSave.health = value
	get:
		return pSave.health

#players last reached checkpoint, the location where the respawn on death
var lastCheckpoint = Vector2(104, 100):
	set(value):
		pSave.lastCheckpoint = value
		pSave.position = value
	get:
		return pSave.lastCheckpoint

# if new game button pressed, then create new save data.
func new_game():
	pSave = PlayerSave.new()
	
# loads the previous state of the game
func load_game():
	pSave = PlayerSave.load_or_create()
	save()
# Saves progress to player save data.
func save():
	pSave.save()
