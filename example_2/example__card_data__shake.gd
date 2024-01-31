extends ExampleCardUIData

func handle_power_type(card_pile_ui : CardPileUI, _card : CardUI):
	card_pile_ui.get_parent().mana += randi_range(5, 10)
