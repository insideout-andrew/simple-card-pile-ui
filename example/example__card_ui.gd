extends CardUI


@onready var label := $FrontFaceTextureRect/Label


func _ready():
	super()
	label.text = card_data.nice_name

