extends Area2D
class_name PeaceNPC

signal npc_hit (is_enemy: bool)

func _on_area_entered(area):
	if area is Bullet:
		npc_hit.emit(false)
