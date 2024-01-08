extends Area2D
# Connected Signal Method, checks if player enters rope body, updates player state
func _on_body_entered(body):
	if body.is_in_group("player"):
		#print("Entered")
		body.climbing = true
	pass

# Connected Signal Method, checks if player exits rope body, updates player state
func _on_body_exited(body):
	if body.is_in_group("player"):
		#print("exited")
		body.climbing = false
	pass
