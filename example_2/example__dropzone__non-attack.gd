extends CardDropzone

func card_ui_dropped(card_ui : CardUI):
	if card_pile_ui:
		get_parent().mana -= card_ui.card_data.cost
		if card_ui.card_data.type == "Block":
			get_parent().block += card_ui.card_data.block_amount
		if card_ui.card_data.type == "Power":
			card_ui.card_data.handle_power_type(card_pile_ui, card_ui)
		card_pile_ui.set_card_pile(card_ui, CardPileUI.Piles.discard_pile)

func can_drop_card(card_ui : CardUI):
	var type_matches = card_ui.card_data.type == "Block" or card_ui.card_data.type == "Power"
	return type_matches and get_parent().mana >= card_ui.card_data.cost
