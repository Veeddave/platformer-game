extends HitBox

func _ready():
	pass

func hit_confirmed():
	owner.queue_free()
