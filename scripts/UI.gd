extends CanvasLayer
class_name UI

signal request_accept()
signal request_path(points: PackedVector3Array)

@onready var request_visual := %"Request Visual" as RequestVisual
@onready var time := %Time as Label
@onready var path_drawer := %"Path Drawer" as PathDrawer

func update_time(time: WorldTime) -> void:
	self.time.text = time.as_string()

func _on_button_pressed() -> void:
	request_visual.show_request(Band.new("Sai, Hetero!", "Rua A", "Rua B", WorldTime.new(14, 0)))

func _on_control_resized() -> void:
	await get_tree().process_frame
	request_visual.update_position_and_size()

func _on_request_visual_accept() -> void:
	path_drawer.start_point_collection()
	emit_signal("request_accept")
	
func _on_end_path_drawing_pressed() -> void:
	var points := path_drawer.get_points()
	path_drawer.stop_point_collection()
	emit_signal("request_path", points)
