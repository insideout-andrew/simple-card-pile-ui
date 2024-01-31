class_name ExampleCardUIData extends CardUIData

@export var type : String
@export var cost : int
@export var description : String

func upgrade():
	pass

func format_description():
	return description
