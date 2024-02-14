extends Control
class_name PathDrawer

@onready var line := $Line as Line3D
@onready var selector := $Selector as Sprite3D

var _collecting_points := false

func start_point_collection() -> void:
	_collecting_points = true
	selector.visible = true
	
func stop_point_collection() -> void:
	_collecting_points = false
	selector.visible = false
	line.curve.clear_points()
	line.visible = false

func get_points() -> PackedVector3Array:
	return line.get_points()

func  _unhandled_input(event: InputEvent) -> void:
	if not  _collecting_points:
		return
	
	if event is InputEventMouseMotion:
		var mouse_position := get_viewport().get_mouse_position()
		var world_position := get_viewport().get_camera_3d().project_position(mouse_position, get_viewport().get_camera_3d().position.y - 2)
		
		world_position.x = floorf(world_position.x)
		if int(world_position.x) % 2 == 0:
			world_position.x += 1
			
		world_position.z = floorf(world_position.z)
		if int(world_position.z) % 2 == 0:
			world_position.z += 1
		
		selector.position = Vector3(world_position.x, 5, world_position.z)
	elif event is InputEventMouseButton:
		if not event.pressed:
			return
			
		match event.button_index:
			1:
				var mouse_position := get_viewport().get_mouse_position()
				var world_position := get_viewport().get_camera_3d().project_position(mouse_position, get_viewport().get_camera_3d().position.y - 2)
				
				world_position.x = floorf(world_position.x)
				if int(world_position.x) % 2 == 0:
					world_position.x += 1
					
				world_position.z = floorf(world_position.z)
				if int(world_position.z) % 2 == 0:
					world_position.z += 1
				
				for point in line.get_points():
					if point == world_position:
						return
				
				if line.curve.point_count > 1:
					var last_position := line.curve.get_point_position(line.curve.point_count - 1)
					
					var dir := last_position - world_position
					if dir.x != 0 and dir.z != 0:
						return
				
				line.curve.add_point(world_position)
				line.visible = line.curve.point_count > 1
			2:
				if line.curve.point_count == 2:
					line.curve.clear_points()
				elif line.curve.point_count > 2:
					line.curve.remove_point(line.curve.point_count - 1)
				
				line.visible = line.curve.point_count > 1
				
		
