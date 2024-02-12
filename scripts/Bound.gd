extends Area2D

@export var bound: float

func _ready():
	update_size_and_position()
	get_tree().get_root().size_changed.connect(_on_size_changed)

func _on_size_changed():
	update_size_and_position()

func update_size_and_position():
	var screen_size = get_viewport().get_visible_rect().size
	
	self.position = screen_size / 2
	
	$CollisionShape2D.shape.size = screen_size - Vector2(bound, bound)
	
