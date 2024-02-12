extends CharacterBody3D

@export var speed: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var path_follow: PathFollow3D = $".."
@onready var path: Path3D = $"../.."

func _ready():
	var curve = Curve3D.new()
	curve.add_point(Vector3())
	
	path.curve = curve

func _physics_process(delta):
	path_follow.progress_ratio += 0.1 * delta
	
