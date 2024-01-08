class_name HitBox
extends Area2D

@export var damage := 1
var player

func _init():
	collision_layer = 2  # the hitbox collision layer is 2
	#collision_mask = 0  # detect all collisions

func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _process(delta):
	pass

func _on_area_entered(area):
	if area == null or not (area is HurtBox) or (area.get_parent() == self.get_parent()):
		return
	if area.is_in_group("player_hurtbox"):
		player = area
		if not is_in_group("lava"):
			owner.in_range = true

func _on_area_exited(area):
	if area.is_in_group("player_hurtbox"):
		if not is_in_group("lava"):
			owner.in_range = false
		player = null

func deal_damage():
	if player != null:
		player.get_hit()

func hit_confirmed():
	pass
