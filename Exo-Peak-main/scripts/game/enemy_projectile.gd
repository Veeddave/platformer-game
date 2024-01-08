extends AnimatedSprite2D

@onready var parent = get_parent()
var grow

func _init():
	grow = 0

func _ready():
	pass

func _process(_delta):
	if grow == 0:
		grow += 1
		grow_animation()
	await self.animation_finished
	
	shoot_animation()

func grow_animation():
	play("grow")

func shoot_animation():
	play("shoot")
