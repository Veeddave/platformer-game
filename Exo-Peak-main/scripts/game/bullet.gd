extends CharacterBody2D

@export var damage : int = 10
@export var GRAVITY : float = 80
@export var SPEED : int = 700
var direction : Vector2 = Vector2(1,0)
var left
var right

func init(dir: Vector2):
	direction = dir
	left = 0
	right = 0

func _ready():
	velocity = SPEED * direction
	
	# horz projectile gets deleted if it never finds it's target
	if not is_in_group("vertical_projectile"):
		await get_tree().create_timer(.5).timeout
		queue_free()

func _physics_process(_delta):
	if is_in_group("vertical_projectile"):
		gravity(_delta)
		if is_on_floor():
			queue_free()
		if is_on_ceiling():
			velocity.y = 0
	else:
		if direction == Vector2(-1, 0) and left == 0:
			scale.x = -1
			left += 1
		elif direction == Vector2(1, 0) and right == 0:
			scale.x = 1
			right += 1
	move_and_slide()

func gravity(delta):
	var grav = GRAVITY
	velocity.y += grav * delta
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
