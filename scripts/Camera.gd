extends Camera3D
class_name TycoonCamera

enum CameraMode {
	PAN,
	DEFINING_PATH,
}

@export var speed: float
@export var deadzone_radius: float

@export var min_zoom: float
@export var max_zoom: float
@export var zoom_speed: float
var zoom := 1.0

@onready var movement_viewer: Line2D = $PanViewer

var origin_pos := Vector2.ZERO
var moving := false

var no_zoom_position := Vector3.ZERO

var pan_position := Vector3.ZERO
var pan_rotation := Vector3.ZERO
var mode := CameraMode.PAN

func _ready() -> void:
	pan_position = position
	pan_rotation = rotation_degrees
	no_zoom_position = position

func _process(delta: float) -> void:
	var mouse_position := get_viewport().get_mouse_position()
	
	if Input.is_action_just_pressed("ui_accept"):
		origin_pos = mouse_position
		moving = true
		movement_viewer.add_point(mouse_position)
		movement_viewer.add_point(mouse_position)
	elif Input.is_action_just_released("ui_accept"):
		moving = false
		movement_viewer.clear_points()
		
	if moving:
		var dir := mouse_position - origin_pos
		var dir_norm := dir.normalized()
		movement_viewer.set_point_position(1, origin_pos + dir_norm * deadzone_radius * 2)
		
		if dir.length() < deadzone_radius:
			return
		
		var position2d := dir_norm * speed * delta
		no_zoom_position += Vector3(position2d.x, 0, position2d.y)
		
		if mode == CameraMode.PAN:
			pan_position = no_zoom_position
			pan_rotation = rotation_degrees
	
	position = no_zoom_position + get_global_transform().basis.z.normalized() * zoom
	
	if mode == CameraMode.DEFINING_PATH:
		var zoom01 := (zoom + absf(min_zoom)) / (max_zoom + absf(min_zoom))
		size = 2.5 + (zoom01) * (25 - 2.5)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 4 and event.pressed:
			zoom = clamp(zoom - zoom_speed, min_zoom, max_zoom)
		if event.button_index == 5 and event.pressed:
			zoom = clamp(zoom + zoom_speed, min_zoom, max_zoom)

func set_mode(mode: CameraMode) -> void:
	self.mode = mode
	
	match mode:
		CameraMode.PAN:
			position = no_zoom_position + get_global_transform().basis.z.normalized() * zoom
			rotation_degrees = pan_rotation
			projection = Camera3D.PROJECTION_PERSPECTIVE
		CameraMode.DEFINING_PATH:
			position.y = 30
			rotation_degrees.x = -90
			projection = Camera3D.PROJECTION_ORTHOGONAL
