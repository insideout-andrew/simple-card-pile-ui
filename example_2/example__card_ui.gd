class_name Example2CardUI extends CardUI


# these are custom variables they will be set with data from *collection.json
@export var value : int
@export var type : String
@export var cost : int
@export var description : String


@onready var cost_label = $Frontface/CostLabel
@onready var power_label = $Frontface/PowerLabel
@onready var name_label = $Frontface/NameLabel
@onready var type_label = $Frontface/TypeLabel
@onready var texture_rect_2 = $Frontface/TextureRect2


func _ready():
	super()
	card_data.connect("card_data_updated", _update_display)
	_update_display()

func upgrade():
	value += 1
	_update_display()
	
func _update_display():
	cost_label.text = "%s" % card_data.cost
	name_label.text = "%s" % card_data.nice_name
	type_label.text = "%s" % card_data.type
	if card_data.type == "Attack":
		power_label.text = "%s" % card_data.power
		texture_rect_2.modulate = Color.WHITE
	elif card_data.type == "Block":
		power_label.text = "%s" % card_data.block_amount
		texture_rect_2.modulate = Color.AQUA
	else:
		power_label.visible = false
