extends AnimatedSprite2D

@onready var parent = get_parent()
var grow
var shrink

func _init():
	grow = 0
	shrink = 0

func _ready():
	pass

func _process(_delta):
	if owner.velocity.y >= 0:
		flip_down()
		if grow == 0:
			grow += 1
			grow_animation()
		await self.animation_finished
	elif owner.velocity.y >= -4:
		if shrink == 0:
			shrink += 1
			shrink_animation()
		await self.animation_finished
	
	shoot_animation()

func grow_animation():
	play("grow")

func shrink_animation():
	play("shrink")

func shoot_animation():
	play("shoot")

func flip_up():
	parent.scale.y = 1

func flip_down():
	scale.y = -1
