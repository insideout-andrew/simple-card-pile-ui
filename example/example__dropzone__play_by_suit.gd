extends CardDropzone

@export var accept_suit : String

func can_drop_card(card_ui : CardUI):
	return card_ui.card_data.suit == accept_suit
