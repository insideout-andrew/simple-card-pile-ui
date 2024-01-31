class_name ExampleCardUIDataAttack extends ExampleCardUIData

@export var power : int

func upgrade():
	power += 2
	emit_signal("card_data_updated")

func format_description():
	return description.replace("{value}", "[color=red]%s[/color]" % power)
