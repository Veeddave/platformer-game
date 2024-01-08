extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("wowowowowo")
		PlayerData.level_num = 3
		AchievementManager.increase_achievement_progress("stage_2_complete", 1)
