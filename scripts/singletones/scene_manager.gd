class_name SceneManager extends Node

#var player: Player
#var scenes_dir: String = "res://scenes/"

#func change_scene(from, to_scene_name: String):
	#player = from.player
	#player.get_parent().remove_child(player)
	#print(from.get_node("Player"))
	#TODO: Обрабатывать если сцена не найдена	
	#var full_path: String = scenes_dir + to_scene_name + ".tscn"
	#from.get_tree().call_deferred("change_scene_to_file", full_path)

func change_scene(from, to_scene: NodePath):
	from.get_tree().call_deferred("change_scene_to_file", to_scene)
