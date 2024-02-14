extends Object
class_name Band

var name: String
var departure_street: String
var arrival_street: String
var departure_time: WorldTime

func _init(name: String, departure_street: String, arrival_street: String, departure_time: WorldTime) -> void:
	self.name = name
	self.departure_street = departure_street
	self.arrival_street = arrival_street
	self.departure_time = departure_time
