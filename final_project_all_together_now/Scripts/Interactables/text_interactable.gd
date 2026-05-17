extends Interactable

@export var dialogue = []
var index = 0
@onready var dialogue_textbox: ColorRect = $DialogueTextbox
@onready var dialogue_text: RichTextLabel = $DialogueTextbox/DialogueText

func _ready():
	dialogue_textbox.visible = false
	dialogue_text.text = dialogue[index]


func interact():
	if index == dialogue.size():
		dialogue_textbox.visible = false
		index = 0
	elif index == 0:
		dialogue_textbox.visible = true
		dialogue_text.text = dialogue[index]
		index += 1
	else: 
		dialogue_text.text = dialogue[index]
		index += 1
