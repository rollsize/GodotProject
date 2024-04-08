extends CharacterBody2D
class_name NPC

@onready var interaction_area: InteractionArea = $InteractionArea
@export var change_to_scene: NodePath

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	await scene_manager.change_scene(get_owner(), change_to_scene)
