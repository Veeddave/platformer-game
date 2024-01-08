extends CanvasLayer

# create our button variables from scene 
@onready var jump : Button = $Settings_Background/jump
@onready var move_up : Button = $Settings_Background/move_up
@onready var move_left : Button = $Settings_Background/move_left
@onready var move_down : Button = $Settings_Background/move_down
@onready var move_right : Button = $Settings_Background/move_right
@onready var label_jump : Label = $Settings_Background/label_jump
@onready var label_move_up : Label = $Settings_Background/label_move_up
@onready var label_move_left : Label = $Settings_Background/label_move_left
@onready var label_move_down : Label = $Settings_Background/label_move_down
@onready var label_move_right : Label = $Settings_Background/label_move_right
@onready var press_panel : PanelContainer = $Settings_Background/PanelContainer
var current_button : Button

func _on_return_to_settings_pressed():
	if MenuButtons.pmenuButton:
		hide()
	else:
		MenuButtons._on_keybindings_back_button_pressed()

func _ready():
	# connect the buttons pressed signal:
	jump.pressed.connect(_on_button_pressed.bind(jump))
	move_up.pressed.connect(_on_button_pressed.bind(move_up))
	move_left.pressed.connect(_on_button_pressed.bind(move_left))
	move_down.pressed.connect(_on_button_pressed.bind(move_down))
	move_right.pressed.connect(_on_button_pressed.bind(move_right))
	# called to refresh the labels
	_update_labels() 
	# hide the panel
	press_panel.hide() 
	

func _on_button_pressed(button: Button) -> void:
	# assign clicked button to current_button
	current_button = button 
	# show the panel
	press_panel.show() 

func _input(event: InputEvent) -> void:
	if !current_button: # return if current_button is null
		return
		
	if event is InputEventKey:
		# add all assigned keys to a dictionary
		var all_inputs : Dictionary = {}
		for action in InputMap.get_actions():
			for input in InputMap.action_get_events(action):
				all_inputs[input.as_text()] = action
		
		# check if the newly pressed key is in dictionary
		# if true delete the old one
		if all_inputs.keys().has(event.as_text()):
			InputMap.action_erase_events(all_inputs[event.as_text()])
	
		# erase the event in the Input map
		InputMap.action_erase_events(current_button.name)
		# and assign the new event to it
		InputMap.action_add_event(current_button.name, event)
		
		# after a key is assigned, set current_button back to null
		current_button = null
		press_panel.hide()
		# refresh the labels
		_update_labels() 
		
func _update_labels() -> void:
	# This is just a quick way to update the labels:
	var jump_key : Array[InputEvent] = InputMap.action_get_events("jump")
	if !jump_key.is_empty():
		label_jump.text = jump_key[0].as_text()
	else:
		label_jump.text = ""
		
	var move_up_key : Array[InputEvent] = InputMap.action_get_events("move_up")
	if !move_up_key.is_empty():
		label_move_up.text = move_up_key[0].as_text()
	else:
		label_move_up.text = ""
		
	var move_left_key : Array[InputEvent] = InputMap.action_get_events("move_left")
	if !move_left_key.is_empty():
		label_move_left.text = move_left_key[0].as_text()
	else:
		label_move_left.text = ""
		
	var move_down_key : Array[InputEvent] = InputMap.action_get_events("move_down")
	if !move_down_key.is_empty():
		label_move_down.text = move_down_key[0].as_text()
	else:
		label_move_down.text = ""
		
	var move_right_key : Array[InputEvent] = InputMap.action_get_events("move_right")
	if !move_right_key.is_empty():
		label_move_right.text = move_right_key[0].as_text()
	else:
		label_move_right.text = ""



