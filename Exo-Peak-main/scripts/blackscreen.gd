@tool

extends Node2D

func _draw():
	draw_rect(get_viewport_transform().affine_inverse()*get_viewport_rect(), Color.BLACK)


func _process(_delta):
	if Engine.is_editor_hint():
		queue_redraw()
