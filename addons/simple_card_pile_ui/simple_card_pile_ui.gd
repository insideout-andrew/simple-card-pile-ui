@tool
class_name SimpleCardPileUI extends EditorPlugin


func _enter_tree():
	add_custom_type("CardPileUI", "Control", preload("card_pile_ui.gd"), preload("card_ui_icon.png"))
	add_custom_type("CardUI", "Control", preload("card_ui.gd"), preload("card_ui_icon.png"))
	add_custom_type("CardDropzone", "Control", preload("card_dropzone.gd"), preload("card_ui_icon.png"))
	add_custom_type("CardPileUIDebugger", "RichTextLabel", preload("card_pile_ui_debugger.gd"), preload("card_ui_icon.png"))

func _exit_tree():
	remove_custom_type("CardPileUI")
	remove_custom_type("CardUI")
	remove_custom_type("CardDropzone")
	remove_custom_type("CardPileUIDebugger")
