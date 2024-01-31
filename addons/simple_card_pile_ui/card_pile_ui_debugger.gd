class_name CardPileUIDebugger extends RichTextLabel

@export var card_pile_ui : CardPileUI


func _ready():
	text += "Signal Debugger:\n"
	card_pile_ui.connect("draw_pile_updated", func(): text += "Draw Pile Updated\n")
	card_pile_ui.connect("hand_pile_updated", func(): text += "Hand Pile Updated\n")
	card_pile_ui.connect("discard_pile_updated", func(): text += "Discard Pile Updated\n")
	card_pile_ui.connect("card_removed_from_dropzone", func(_dropzone, _card): text += "Card Removed From Dropzone\n")
	card_pile_ui.connect("card_added_to_dropzone", func(_dropzone, _card): text += "Card Added To Dropzone\n")
	card_pile_ui.connect("card_hovered", func(card): text += "%s hovered\n" % card.card_data.nice_name)
	card_pile_ui.connect("card_unhovered", func(card): text += "%s unhovered\n" % card.card_data.nice_name)
	card_pile_ui.connect("card_clicked", func(card): text += "%s clicked\n" % card.card_data.nice_name)
	card_pile_ui.connect("card_dropped", func(card): text += "%s dropped\n" % card.card_data.nice_name)
	card_pile_ui.connect("card_removed_from_game", func(card): text += "%s removed from game\n" % card.card_data.nice_name)
