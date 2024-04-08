extends Control
class_name SettingsMenu

signal exit_settings_menu

@onready var back_button = $MarginContainer/VBoxContainer/BackButton

func _ready():
	self.hide()
	back_button.button_down.connect(_on_back_button_pressed)
	set_process(false)
	
func _on_back_button_pressed():
	exit_settings_menu.emit()
	set_process(false)
