@tool
extends StaticBody2D

@export var rect : Rect2i = Rect2i(0,0,64,64) : set = _set_rect

var readied = false

func _set_rect(new_rect : Rect2i):
	rect = new_rect
	if readied:
		update_bounds()
		queue_redraw()

func _ready():
	update_bounds()
	readied = true

func update_bounds():
	$left.position = rect.position
	$top.position = rect.position
	$right.position = rect.position + Vector2i(rect.size.x + 1, 0)
	$bottom.position = rect.position + Vector2i(0, rect.size.y + 1)

func _draw():
	if Engine.is_editor_hint():
		draw_rect(Rect2i(rect.position, rect.size), Color.CORNFLOWER_BLUE, false)
