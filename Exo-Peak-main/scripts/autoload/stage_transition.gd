extends Area2D
# Upon entering the collision area, set level to two,
func _on_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.lastCheckpoint = Vector2(13,99)
		PlayerData.level_num = 2
		AchievementManager.increase_achievement_progress("stage_1_complete", 1)
		MenuButtons._on_play_button_pressed(2)
	pass 
