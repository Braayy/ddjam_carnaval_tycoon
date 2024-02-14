extends Object
class_name WorldTime

var hours := 0
var minutes := 0

func _init(hours := 0, minutes := 0) -> void:
	self.hours = hours
	self.minutes = minutes

func as_string() -> String:
	return "%02d:%02d" % [hours, minutes]
