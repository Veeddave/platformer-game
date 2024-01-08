extends AnimatedSprite2D

@onready var parent = get_parent()
var hurt : bool = false
var attack : bool = false

func _process(_delta):
	if not owner.alive:
		death_animation()
		await self.animation_finished
		owner.queue_free()
	
	if attack:
		attack_animation()
		await self.animation_finished
		attack = false
	
	if hurt:
		hurt_animation()
		await self.animation_finished
		hurt = false
	
	if owner.follow_player and not owner.immobile:
		walk_animation()
	else:
		idle_animation()
		idle_flip()


func attack_animation():
	if owner.can_bite:
		play("bite")
	else:
		if is_in_group("attack"):
			play("attack")

func death_animation():
	play("death")

func walk_animation():
	play("walk")

func idle_animation():
	play("idle")

func hurt_animation():
	play("hurt")

func idle_flip():
	if $idle_timer.is_stopped():
		if not owner.face_left:
			flip_left()
		else:
			flip_right()
		$idle_timer.start()

func flip_right():
	parent.scale.x = -1
	owner.face_left = false

func flip_left():
	parent.scale.x = 1
	owner.face_left = true
