extends Node3D

@onready var ui := $UI as UI
@onready var camera := $Camera as TycoonCamera
@onready var path := $Path as Path3D

var time := WorldTime.new()

func _on_time_timeout() -> void:
	time.minutes += 10
	
	if time.minutes == 60:
		time.minutes = 0
		time.hours += 1
		
		if time.hours == 24:
			time.hours = 0
	
	ui.update_time(time)

func _on_ui_request_accept() -> void:
	camera.set_mode(TycoonCamera.CameraMode.DEFINING_PATH)

func _on_ui_request_path(points: PackedVector3Array) -> void:
	camera.set_mode(TycoonCamera.CameraMode.PAN)
	for point in points:
		path.curve.add_point(point)
