extends Control
class_name PauseMenu
# Called when the node enters the scene tree for the first time.

func _ready():
	self.hide()

func _on_resume_pressed():
	get_tree().set_pause(false)
	self.hide()

func _on_exit_pressed():
	#TODO: Delete bullets
	get_tree().quit()
