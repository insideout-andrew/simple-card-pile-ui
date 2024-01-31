extends CardDropzone

func card_ui_dropped(card_ui):
	card_pile_ui.set_card_pile(card_ui, CardPileUI.Piles.discard_pile)
