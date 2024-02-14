@tool
extends Path3D
class_name Line3D

@export var curve_points: PackedVector3Array:
	set = set_points, get = get_points
@export var width : float = 0.1:
	set = set_width
@export var width_curve : Curve:
	set = set_width_curve

@export var default_color : Color = Color.WHITE:
	set = set_default_color
@export var gradient : GradientTexture1D:
	set = set_gradient

@export var texture : Texture:
	set = set_texture
@export_enum("None", "Tile", "Stretch", "Double Sided Tile") var texture_mode = 2:
	set = set_texture_mode

@export var flat : bool = false:
	set = set_flat
@export_enum("Follow Main Camera", "Custom") var flat_direction = 0:
	set = set_flat_direction
@export var custom_flat_direction := Vector3(0,1,0):
	set = set_custom_flat_direction
@export var resolution : float = 1.0:
	set = set_resolution
@export var cross_section_resolution : int = 10:
	set = set_cross_section_resolution
@export var smooth : bool = false:
	set = set_smooth

@export var generate_collision_mesh := false:
	set = set_generate_collision_mesh
@export_enum("Convex", "Concave") var collision_mesh_type

@export var global_coords : bool = false:
	set = set_global_coords

@export var custom_material: Material:
	set = set_material

var geometry:MeshInstance3D = null
var geometry_script = preload("res://addons/line_3d/MeshInstance.gd")

func _enter_tree() -> void:
	reload_geometry()
	update()

func reload_geometry():
	if geometry == null:
		geometry = get_node_or_null('GeometryMeshInstance')
	
	var new = false
	if geometry == null:
		geometry = MeshInstance3D.new()
		new = true
		
	geometry.name = 'GeometryMeshInstance'
	geometry.set_script(geometry_script)
	
	if new:
#		if Engine.editor_hint:
#			geometry.connect('script_changed', self, 'update')
		add_child(geometry)

func _ready() -> void:
	connect('curve_changed', update)
#	if Engine.editor_hint:
#		connect('script_changed', self, 'update')
	update()
	
	if generate_collision_mesh and geometry != null and geometry.get_node_or_null('GeometryMeshInstance_col') == null:
		if collision_mesh_type == 0:
			geometry.create_multiple_convex_collisions()
		else:
			geometry.create_trimesh_collision()
		if not global_coords:
			geometry.get_node('GeometryMeshInstance_col').transform.origin = -transform.origin
	
func update():
	if geometry == null:
		call_deferred('reload_geometry')
	else:
		geometry.call_deferred('update')


func set_width(v):
	width = v
	update()
	
	
func set_width_curve(v):
	width_curve = v
	if width_curve != null:
		width_curve.connect('changed', update)
	update()
	
	
func set_global_coords(v):
	global_coords = v
	if Engine.is_editor_hint():
		set_notify_transform(global_coords)
	update()


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		update()
	
func set_texture_mode(v):
	texture_mode = v
	update()
	
	
func set_texture(v):
	texture = v
	update()
	
	
func set_default_color(v):
	default_color = v
	update()
	
	
func set_gradient(v):
	gradient = v
	if gradient != null:
		gradient.connect('changed', update)
	update()
	
	
func set_flat(v):
	flat = v
	update()
	
	
func set_material(v):
	custom_material = v
	update()
	
	
func set_resolution(v):
	resolution = v
	update()
	
	
func set_cross_section_resolution(v):
	cross_section_resolution = v
	update()
	
	
func set_smooth(v):
	smooth = v
	update()
	
	
func set_flat_direction(v):
	flat_direction = v
	update()
	
	
func set_custom_flat_direction(v):
	custom_flat_direction = v
	update()
	
func set_generate_collision_mesh(v):
	generate_collision_mesh = v
	
	
func set_points(v):
	for i in range(v.size()):
		curve.set_point_position(i, v[i])
	update()
	
	
func get_points() -> PackedVector3Array:
	var ret = PackedVector3Array()
	for i in range(curve.get_point_count()):
		ret.append(curve.get_point_position(i))
	return ret
