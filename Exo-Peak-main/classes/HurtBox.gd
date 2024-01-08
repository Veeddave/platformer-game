class_name HurtBox
extends Area2D

var hit

func _init():
	#collision_layer = 0
	collision_mask = 2  # detect hitbox collisions
	pass

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hit):
	if hit == null or not (hit is HitBox) or (hit.get_parent() == self.get_parent()):
		return
	if hit.is_in_group("enemy_projectile") and is_in_group("enemy_hurtbox"):
		return
	self.hit = hit

func _process(delta):
	if hit != null:
		if hit.has_method("hit_confirmed"):
			hit.hit_confirmed()
		if hit.is_in_group("projectile"):
			get_hit()

func get_hit():
	if owner.has_method("take_damage"):
		owner.take_damage(hit.damage)
