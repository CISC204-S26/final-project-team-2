extends Interactable

@export var toggled = false
@export var vertical = false
signal onSwitchInteracted(toggled: bool)

func _ready():
	$VerticalSprite.hide()
	$HorizontalSprite.hide()
	if vertical:
		$VerticalSprite.show()
		if toggled:
			$VerticalSprite.frame = 1
		else:
			$VerticalSprite.frame = 0
	else:
		$HorizontalSprite.show()
		if toggled:
			$HorizontalSprite.frame = 1
		else:
			$HorizontalSprite.frame = 0
	

func interact():
	if toggled == false:
		toggled = true
		if vertical:
			$VerticalSprite.frame = 1
		else:
			$HorizontalSprite.frame = 1
		#print("Switched ON")
	else:
		toggled = false
		if vertical:
			$VerticalSprite.frame = 0
		else:
			$HorizontalSprite.frame = 0
		#print("Switched OFF")
	onSwitchInteracted.emit(toggled)
