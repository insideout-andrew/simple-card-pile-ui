class_name CardUI extends Control


signal card_hovered(card: CardUI)
signal card_unhovered(card: CardUI)
signal card_clicked(card: CardUI)
signal card_dropped(card: CardUI)


@onready var frontface = $FrontFaceTextureRect 
@onready var backface = $BackFaceTextureRect


@export var card_data : CardUIData


var frontface_texture : String
var backface_texture : String
var is_clicked := false
var mouse_is_hovering := false
var target_position := Vector2.ZERO
var speed := 0.2
var return_speed := 0.2
var hover_distance := 10
var drag_when_clicked := true

func get_class(): return "CardUI"
func is_class(name): return name == "CardUI"


func set_direction(dir : Vector2):
	backface.visible = dir == Vector2.DOWN
	frontface.visible = dir == Vector2.UP

func set_disabled(val : bool):
	if val:
		mouse_is_hovering = false
		is_clicked = false
		rotation = 0
		var parent = get_parent()
		if parent is CardPileUI:
			parent.reset_card_ui_z_index()
			
func _ready():
	connect("mouse_entered", _on_mouse_enter)
	connect("mouse_exited", _on_mouse_exited)
	connect("gui_input", _on_gui_input)
	if frontface_texture:
		frontface.texture = load(frontface_texture)
		backface.texture = load(backface_texture)
		custom_minimum_size = frontface.texture.get_size()
		pivot_offset = frontface.texture.get_size() / 2



func _card_can_be_interacted_with():
	var parent = get_parent()
	var valid = false
	if parent is CardPileUI:
		# check for cards in hand
		if parent.is_card_ui_in_hand(self):
			valid = parent.is_hand_enabled() and not parent.is_any_card_ui_clicked()
		# check for cards in dropzone
		var dropzone = parent.get_card_dropzone(self)
		if dropzone:
			valid = dropzone.get_top_card() == self
	return valid
			


func _on_mouse_enter():
	#check if is hovering should be turned on
	if _card_can_be_interacted_with():
		mouse_is_hovering = true
		target_position.y -= hover_distance
		var parent = get_parent()
		parent.reset_card_ui_z_index()
		emit_signal("card_hovered", self)


func _on_mouse_exited():
	if is_clicked:
		return
	if mouse_is_hovering:
		mouse_is_hovering = false
		target_position.y += hover_distance
		var parent = get_parent()
		if parent is CardPileUI:
			parent.reset_card_ui_z_index()
		emit_signal("card_unhovered", self)
	
func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var parent = get_parent()
			
			if _card_can_be_interacted_with():
				is_clicked = true
				rotation = 0
				parent.reset_card_ui_z_index()
				emit_signal("card_clicked", self)
			
			if parent is CardPileUI and parent.get_card_pile_size(CardPileUI.Piles.draw_pile) > 0 and parent.is_hand_enabled() and parent.get_cards_in_pile(CardPileUI.Piles.draw_pile).find(self) != -1 and not parent.is_any_card_ui_clicked() and parent.click_draw_pile_to_draw:
				parent.draw(1)
		else:
			#event released
			if is_clicked:
				is_clicked = false
				mouse_is_hovering = false
				rotation = 0
				var parent = get_parent()
				if parent is CardPileUI and parent.is_card_ui_in_hand(self):
					parent.call_deferred("reset_target_positions")
				var all_dropzones := []
				get_dropzones(get_tree().get_root(), "CardDropzone", all_dropzones)
				for dropzone in all_dropzones:
					if dropzone.get_global_rect().has_point(get_global_mouse_position()):
						if dropzone.can_drop_card(self):
							dropzone.card_ui_dropped(self)
							break
				emit_signal("card_dropped", self)
				emit_signal("card_unhovered", self)
			

func get_dropzones(node: Node, className : String, result : Array) -> void:
	if node is CardDropzone:
		result.push_back(node)
	for child in node.get_children():
		get_dropzones(child, className, result)

func _process(_delta):
	if is_clicked and drag_when_clicked:
		target_position = get_global_mouse_position() - custom_minimum_size * 0.5
	if is_clicked:
		position = lerp(position, target_position, speed)
	else:
		position = lerp(position, target_position, return_speed)
		
