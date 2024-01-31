extends CardDropzone

func card_ui_dropped(card_ui : CardUI):
	if card_pile_ui:
		get_parent().mana -= 1
		card_ui.card_data.upgrade()
		card_pile_ui.set_card_pile(card_ui, CardPileUI.Piles.discard_pile)

func can_drop_card(_card_ui : CardUI):
	return get_parent().mana >= 1
