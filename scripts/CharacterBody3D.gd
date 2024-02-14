extends CharacterBody3D

@export var speed: float

@onready var path_follow: PathFollow3D = $".."
@onready var path: Path3D = $"../.."

func _ready() -> void:
	var curve := Curve3D.new()
	curve.add_point(Vector3())
	
	path.curve = curve

func _physics_process(delta: float) -> void:
	path_follow.progress_ratio += 0.1 * delta
	
