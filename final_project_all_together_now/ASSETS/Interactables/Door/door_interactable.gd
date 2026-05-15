extends Interactable

#@export var level_to_complete: int
@export var open: bool
signal level_complete

func _ready():
	if not open:
		$DoorSprites.play("closed")
	else:
		$DoorSprites.play("opened")

func open_door():
	open = true
	$DoorSprites.play("opened")

func interact():
	if open:
		Global.completed_levels[get_parent().level-1] = true
		print(Global.completed_levels)
		level_complete.emit()
