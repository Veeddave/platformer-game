class_name Enemy
extends CharacterBody2D

@onready var projectile_1 = preload("res://scenes/projectiles/projectile_1.tscn")
@onready var projectile_2 = preload("res://scenes/projectiles/projectile_2.tscn")
@onready var projectile_3 = preload("res://scenes/projectiles/projectile_3.tscn")
@onready var projectile_4 = preload("res://scenes/projectiles/projectile_4.tscn")
@onready var projectile_5 = preload("res://scenes/projectiles/projectile_5.tscn")

@export var damage_dealt = 1
@export var health: float = 3
@export var SPEED : float = 125
@export var FALL_STRENGTH : float = 2
@export var GRAVITY : float = 375
@export var can_bite : bool 
@export var immobile : bool
@export var projectile_enabled : bool
@export var disable_damage_on_touch : bool

@export_range(0, 1.0) var ACCELERATION : float = 0.5
@export_range(0, 1.0) var FRICTION : float = 0.5
var alive : bool = true
var follow_player = false
var player = null
var in_range
var face_left : bool
var projectile

func _init():
	scale.x = -1
	face_left = true
	
	collision_layer = 256 # Entity Collider
	collision_mask = 16 | 32 | 256  # Solid, Platform, Entity Collider

func _physics_process(delta):
	if in_range or (is_in_group("explosive") and not alive):
		attack()
	else:
		$Flippable/enemy.attack = false
	
	if follow_player and alive:
		if not immobile:
			position.x += (player.position.x - position.x)/SPEED
		
		if (player.position.x - position.x) < 0:
			if not face_left:
				$Flippable/enemy.flip_left()
		else:
			if face_left:
				$Flippable/enemy.flip_right()
		
		if projectile_enabled and $Flippable/hitbox/cooldown_timer.is_stopped():
			shoot()
			$Flippable/hitbox/cooldown_timer.start()
	
	var grav = GRAVITY
	if (velocity.y >= 0):
		grav *= FALL_STRENGTH
	
	velocity.y += grav * delta
	#set_velocity(velocity)
	move_and_slide()

func _on_detection_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body == null:
		return
	if body.is_in_group("player"):
		player = body
		follow_player = true

func _on_detection_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == null:
		return
	if body.is_in_group("player"):
		follow_player = false
		player = null
		#$Flippable/enemy.flip_right()

func take_damage(amount : int):
	health -= amount
	$Flippable/enemy.hurt = true
	$health_bar.value = health
	if (health <= 0):
		alive = false

func attack():
	if disable_damage_on_touch:
		return
	if is_in_group("explosive"):
		alive = false
		await $Flippable/enemy.animation_finished
		$Flippable/hitbox.deal_damage()
		return
	if $Flippable/hitbox/cooldown_timer.is_stopped() and in_range:
		$Flippable/hitbox.deal_damage()
		$Flippable/enemy.attack = true
		$Flippable/hitbox/cooldown_timer.start()

func shoot():
	$Flippable/enemy.attack = true
	get_projectile()
	var b = projectile.instantiate()
	b.init(Vector2(-$Flippable.scale.x, 0))
	add_sibling(b)
	b.global_position = $Flippable/Muzzle.global_position

func get_projectile():
	if projectile_enabled:
		if is_in_group("projectile_1"):
			projectile = projectile_1
		elif is_in_group("projectile_2"):
			projectile = projectile_2
		elif is_in_group("projectile_3"):
			projectile = projectile_3
		elif is_in_group("projectile_4"):
			projectile = projectile_4
		else:
			projectile = projectile_5
