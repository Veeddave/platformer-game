extends AnimatedSprite2D

@onready var parent = get_parent()


func _process(_delta):
	
	var on_floor = owner.is_on_floor()
	
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var just_right = Input.is_action_just_pressed("move_right")
	var just_left = Input.is_action_just_pressed("move_left")
	
	if (right or left) and on_floor:
		play("walking", abs(owner.velocity.x)/3.0)
	elif not on_floor:
		play("jump")
	else:
		play("default")
	
	if right and not left:
		parent.scale.x = 1
	elif left and not right:
		parent.scale.x = -1
	elif just_right:
		parent.scale.x = 1
	elif just_left:
		parent.scale.x = -1
	

