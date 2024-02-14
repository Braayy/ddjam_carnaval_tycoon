extends Sprite3D

@export var color_speed: float

func _process(delta: float) -> void:
	modulate.h += color_speed * delta
	if modulate.h > 1:
		modulate.h = 0
