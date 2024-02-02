extends Node2D


@onready var mana_label = $ManaLabel
@onready var card_pile_ui = $CardPileUI
@onready var block_card_dropzone = $BlockCardDropzone
@onready var block_label = $BlockLabel
@onready var panel_container = $PanelContainer
@onready var rich_text_label = $PanelContainer/RichTextLabel
@onready var targeting_line_2d = $TargetingLine2D


# seems like these 3 properties would make more sense in as a singleton in a real game?
var starting_mana := 4
var current_hovered_card : CardUI

var block := 0 :
	set(val):
		block = val
		_update_display()
		
var mana := 4 :
	set(val):
		mana = val
		_update_display()

func _ready():
	card_pile_ui.draw(5)
	card_pile_ui.connect("card_hovered", func(card_ui):
		rich_text_label.text = card_ui.card_data.format_description()
		panel_container.visible = true
		current_hovered_card = card_ui
	)
	card_pile_ui.connect("card_unhovered", func(_card_ui):
		panel_container.visible = false
		current_hovered_card = null
	)
	card_pile_ui.connect("card_clicked", func(card_ui):
		targeting_line_2d.set_point_position(0, card_ui.position + card_ui.size * 0.5)
		targeting_line_2d.visible = true
	)
	card_pile_ui.connect("card_dropped", func(_card_ui):
		targeting_line_2d.visible = false
	)

func _on_end_turn_button_pressed():
	mana = starting_mana
	block = 0
	for card in card_pile_ui.get_cards_in_pile(CardPileUI.Piles.hand_pile):
		card_pile_ui.set_card_pile(card, CardPileUI.Piles.discard_pile)
	card_pile_ui.draw(5)

func _update_display():
	mana_label.text = "%s" % [ mana ]
	block_label.text = "%s" % [ block ]

func _process(_delta):
	if current_hovered_card:
		var target_pos = current_hovered_card.position
		target_pos.y += 80
		target_pos.x += 180
		panel_container.position = target_pos
		targeting_line_2d.set_point_position(1, get_global_mouse_position())
