extends Path2D

@onready var follow_path: PathFollow2D = $PathFollow2D

@export var speed: =0.2

var fowardDirection = 1

func _physics_process(delta: float) -> void:
	follow_path.progress_ratio += speed * delta * fowardDirection
	
	if fowardDirection == 1 and follow_path.progress_ratio == 1:
		fowardDirection = -1
	
	elif fowardDirection == -1 and follow_path.progress_ratio == 0:
		fowardDirection = 1
