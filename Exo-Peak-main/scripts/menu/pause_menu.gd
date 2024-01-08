extends CanvasLayer

var paused := false

# Called when the node enters the scene tree for the first time.
func _ready():
	if visible:
		hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		$"../Game/Player/UI/HealthBar".hide()
		if $"../Settings".visible || $"../Achievements".visible:
			pass
		else:
			if paused:
				$"../Game/Player/UI/HealthBar".show()
				unpause()
			else:
				pause()

func pause():
	get_tree().paused = true
	show()
	paused = true

func unpause():
	get_tree().paused = false
	hide()
	paused = false

func _on_resume_button_pressed():
	$"../Game/Player/UI/HealthBar".show()
	unpause()

func _on_return_button_pressed():
	MenuButtons._on_return_button_pressed()

func _on_achievements_button_pressed():
	MenuButtons.pmenuButton = true
	$"../Achievements".show()

func _on_settings_button_pressed():
	MenuButtons.pmenuButton = true
	$"../Settings".show()

func _on_reset_level_button_pressed():
	PlayerData.health = 8
	PlayerData.spawnerLocation = PlayerData.lastCheckpoint
	MenuButtons._on_play_button_pressed(PlayerData.level_num)

func _on_save_button_pressed():
	PlayerData.spawnerLocation = $"../Game/Player".position
	PlayerData.health = $"../Game/Player".health
	PlayerData.save()
