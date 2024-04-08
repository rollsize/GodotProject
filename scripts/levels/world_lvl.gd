extends Node
#class_name TestLevel
#
#signal toggle_scene_paused(is_paused: bool)
#
#func _input(event):
	#if(event.is_action_pressed("pause")):
		#var is_scene_paused: bool = get_tree().is_paused()
		#get_tree().set_pause(!is_scene_paused)
		#print(is_scene_paused)
		#emit_signal("toggle_scene_paused", !is_scene_paused)
@onready var pause_menu = $"../PauseCanvas/PauseMenu"

func _input(event: InputEvent):
	if(event.is_action_pressed("pause")):
		var is_paused: bool = get_tree().is_paused()
		get_tree().set_pause(!is_paused)
		if(!is_paused): #if need to pause
			pause_menu.show()
		else:
			pause_menu.hide()
