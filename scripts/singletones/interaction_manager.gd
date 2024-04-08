extends Node2D
#TODO:Fix label global position
@onready var player: Player
@onready var label: Label = $Label

const base_text: String = "[E] to "

var active_areas: Array = []
var can_interact: bool = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var area_idx: int = active_areas.find(area)
	if area_idx != -1:
		active_areas.remove_at(area_idx)

func _sort_by_dist_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_dist_to_player)
		label.text = base_text + active_areas[0].action_label
		label.global_position = active_areas[0].global_position
		label.global_position.x -= label.size.x / 2
		label.global_position.y -= 100
		label.show()
	else:
		label.hide()
		
func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
