extends ExampleCardUIData

@export var block_amount : int

func upgrade():
	block_amount += 3
	emit_signal("card_data_updated")

func format_description():
	return description.replace("{value}", "[color=aqua]%s[/color]" % block_amount)
