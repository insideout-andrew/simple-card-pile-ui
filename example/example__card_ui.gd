extends CardUI


@onready var label := $Frontface/Label


func _ready():
	super()
	label.text = card_data.nice_name

