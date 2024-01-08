extends Node

signal scene_change(scene_name: String, level: int)
var disableKeyboard = false
var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Click" : AudioStreamPlayer.new(),
}
var pmenuButton = false

func _ready():
	# set up audio stream players and load sound files
	for k in sounds.keys():
		sounds[k].stream = load("res://assets/audio/sfx/" + str(k) + ".mp3")
		# assign output mixer bus
		sounds[k].bus = &"UI"
		# add them to the scene tree
		add_child(sounds[k])

func _on_return_button_pressed():
	emit_signal("scene_change", "title", 0)

func _on_play_button_pressed(level_num: int):
	emit_signal("scene_change", "game", level_num)

func _on_settings_button_pressed():
	emit_signal("scene_change", "settings", 0)

func _on_achievements_button_pressed():
	emit_signal("scene_change", "achievements", 0)
	
func _on_keybindings_button_pressed():
	emit_signal("scene_change", "keybindings", 0)

func _on_keybindings_back_button_pressed():
	emit_signal("scene_change", "settings", 0)


# to disable ANY input (mouse) during scene transitions
func inputHandle(handle: String):
	match handle:
		"disable":
			disableKeyboard = true
			get_tree().get_root().set_disable_input(true)
			# disable keyboard
		"enable":
			disableKeyboard = false
			get_tree().get_root().set_disable_input(false)
			# enable keyboard

func handleSounds(submenu: Node):
	# connect signals to the method that plays the sounds
	install_sounds(submenu)

func install_sounds(node: Node) -> void:
	for child in node.get_children():
		if child is Button:
			child.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			child.pressed.connect( ui_sfx_play.bind(&"UI_Click") )
		# recursion
		install_sounds(child)

func ui_sfx_play(sound : String) -> void:
	sounds[sound].play()
