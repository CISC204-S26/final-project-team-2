extends Node2D


@export var death_screen: CanvasLayer
var player = null

func _ready():
	# Find the player in the scene
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if player == null:
		return

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
		death_screen.show()
