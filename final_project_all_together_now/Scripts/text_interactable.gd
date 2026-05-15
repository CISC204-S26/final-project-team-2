extends Interactable

@export var text = []
var index = 0
signal enteredTalking
signal exitedTalking
signal showText(text: String)

func interact():
	if index == text.size():
		exitedTalking.emit()
		# used to allow the player to move again after interacting 
		index = 0
	elif index == 0:
		enteredTalking.emit()
		# used to stop the player from moving while interacting 
		showText.emit(text[index])
		index += 1
	else:
		showText.emit(text[index])
		index += 1
