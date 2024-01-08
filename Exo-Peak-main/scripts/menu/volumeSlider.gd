extends HSlider

@export var bus_name: String
var bus_index: int
var userPref: UserPreferences

func _ready() -> void:
	userPref = UserPreferences.load_or_create()

	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	#var soundVal
	
	if userPref:
		match bus_index:
			0:
				value = userPref.master
			1:
				value = userPref.music
			2:
				value = userPref.sfx
			_:
				pass

@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	if userPref:
		match bus_index:
			0:
				userPref.master = value
				userPref.save()
			1:
				userPref.music = value
				userPref.save()
			2:
				userPref.sfx = value
				userPref.save()
			_:
				pass
