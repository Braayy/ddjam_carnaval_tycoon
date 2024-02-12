extends CanvasLayer

signal view_path()
signal camera_pan()

func _on_path_button_pressed():
	emit_signal("view_path")

func _on_pan_button_pressed():
	emit_signal("camera_pan")
