extends Node

var _achievement_dict := {}

func _ready():
	# Initialize achievements (replace this with your actual achievement setup logic)
	init_achievements()

func init_achievements():
	# Create and add achievements to the list
	var achievement1 = Achievement.new("Crash Landing on Who?", "Beat Stage 1", 0)
	var achievement2 = Achievement.new("Peak of the Mountain", "Beat Stage 2", 0)
	var achievement3 = Achievement.new("I fired... and I missed.", "Shoot Your Gun a Lot!", 0)
	var achievement4 = Achievement.new("Who Knew You Could Jump?", "Jump Ten Times!", 0)
	
	#store them in dict
	add_achievement("stage_1_complete", achievement1)
	add_achievement("stage_2_complete", achievement2)
	add_achievement("blast", achievement3)
	add_achievement("jumping", achievement4)

func add_achievement(id: String, ach: Achievement):
	if not id in _achievement_dict:
		_achievement_dict[id] = ach
	else:
		printerr("Tried to add an achievement with id `"+id+"` but it already exists.")

func set_achievement_progress(id: String, progress: int):
	_achievement_dict[id].progress = progress
	
func get_achievement_progress(id: String):
	return _achievement_dict[id].progress

func increase_achievement_progress(id: String, progress: int):
	_achievement_dict[id].progress += progress

func get_achievement_list():
	return AchievementManager._achievement_dict.values()
