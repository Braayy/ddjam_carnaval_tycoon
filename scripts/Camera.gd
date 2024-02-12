extends Camera3D

@export var speed: float

func _ready():
	pass

func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size
	
	var area_position = $Bound.position
	var shape_size = $"Bound/CollisionShape2D".shape.size
	
	var x_min = area_position.x - shape_size.x / 2
	var x_max = area_position.x + shape_size.x / 2
	
	var y_min = area_position.y - shape_size.y / 2
	var y_max = area_position.y + shape_size.y / 2
	
	var dir = Vector3()
	
	if mouse.x < x_min:
		dir.x -= speed * delta
	elif mouse.x > x_max:
		dir.x += speed * delta
		
	if mouse.y < y_min:
		dir.z -= speed * delta
	elif mouse.y > y_max:
		dir.z += speed * delta
	
	position += dir
