extends Node2D
# I know the main menu code is a bit messy but ahh i dont care at this point

@onready var menu_start_button = %MenuStartButton

func _ready():
	menu_start_button.disable()

func _on_menu_button_pressed():
	Global.username = %NameEdit.text_value

	menu_start_button.disabled = true
	%MenuAnimations.play("open")

func menu_cleanup():
	%LightHumming.queue_free()
	%DropdownBottom.queue_free()
	%DropdownTop.queue_free()
	menu_start_button.queue_free()

func _on_menu_input_text_changed(new_text):
	if not new_text == "" and menu_start_button.disabled:
		menu_start_button.enable() 
	elif new_text == "" and not menu_start_button.disabled:
		menu_start_button.disable()