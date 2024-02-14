extends Panel
class_name RequestVisual

signal accept()

@export var slide_duration := 1.0

@export var position_node: Panel

@onready var general_info := %"General Info" as RichTextLabel
@onready var time_info := %"Time Info" as RichTextLabel

var tween: Tween

func show_request(band: Band) -> void:
	general_info.text = "[color=green][b]%s[/b][/color] quer sair da [b]%s[/b] e ir até a [b]%s[/b]" % [band.name, band.departure_street, band.arrival_street]
	time_info.text = "Eles pretendem começar às [b]%sh[/b]" % band.departure_time.as_string()
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "global_position", position_node.global_position, slide_duration)

func update_position_and_size() -> void:
	global_position = Vector2(-position_node.size.x, 32)
	size = Vector2(position_node.size.x, position_node.get_parent_area_size().y)

func hide_request() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(-position_node.size.x, position_node.global_position.y), slide_duration)

func _on_accept_pressed() -> void:
	hide_request()
	emit_signal("accept")

func _on_reject_pressed() -> void:
	hide_request()
