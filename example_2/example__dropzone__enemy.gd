extends CardDropzone

@export var hp := 30

@onready var label = $Label

func _ready():
	label.text = "%s" % hp

func card_ui_dropped(card_ui : CardUI):
	if card_pile_ui:
		get_parent().mana -= card_ui.card_data.cost
		hp -= card_ui.card_data.power
		label.text = "%s" % hp
		card_pile_ui.set_card_pile(card_ui, CardPileUI.Piles.discard_pile)

func can_drop_card(card_ui : CardUI):
	return card_ui.card_data.type == "Attack" and get_parent().mana >= card_ui.card_data.cost
