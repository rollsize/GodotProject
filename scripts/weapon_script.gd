extends Node2D
class_name Weapon

@export var bullet_scene: PackedScene

func _fire():
	var bullet = bullet_scene.instantiate()
	bullet.direction = Vector2.from_angle(global_rotation)
	bullet.global_posittion = global_position
	get_tree().root.add_child(bullet)
