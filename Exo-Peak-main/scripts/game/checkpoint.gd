extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.lastCheckpoint = position
		PlayerData.save()
		print("chek")
