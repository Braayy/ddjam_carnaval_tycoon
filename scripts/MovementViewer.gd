extends Line2D

@export var color_speed: float

func _process(delta):
	default_color.h += color_speed * delta
	if default_color.h > 1:
		default_color.h = 0
