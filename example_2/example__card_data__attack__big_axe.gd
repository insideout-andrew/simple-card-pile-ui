extends ExampleCardUIDataAttack

func upgrade():
	power += 8
	emit_signal("card_data_updated")
