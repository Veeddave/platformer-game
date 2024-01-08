extends Node2D

@onready var Lava = preload("res://scenes/projectiles/lava_projectile.tscn")

func _physics_process(delta):
	if $cooldown_timer.is_stopped():
		shoot()
		$cooldown_timer.start()

func shoot():
	var b = Lava.instantiate()
	b.init(Vector2(0, -1))
	add_sibling(b)
	b.global_position = $Marker2D.global_position
