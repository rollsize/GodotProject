extends Node

@export var enemy_spawn_points: Array[Marker2D] = []
@export var enemy_scene: PackedScene = preload("res://scenes/characters/Enemy.tscn")
@export var peace_npc_scene: Array[PackedScene] = []
@export var max_enemies_alive: int = 2
@onready var npc_spawn_timer: Timer = $NPCSpawnTimer
@onready var task_label = $"../TaskLabel"
@onready var timer_counter = $"../TimerCounter"
@onready var hit_counter = $"../HitCounter"

var random_number = RandomNumberGenerator.new()
var spawned_npc: Array[Node]
var actual_points = 0

func _process(_delta):
	if actual_points >= 10  or actual_points <= -1:
		npc_spawn_timer.stop()
		timer_counter.hide()
		hit_counter.hide()
		actual_points = 0
		_delete_spawned_npc()
	if !npc_spawn_timer.is_stopped():
		var time_left: int = npc_spawn_timer.time_left
		timer_counter.set_text(str(time_left))

func _on_task_timer_timeout():
	task_label.hide()
	timer_counter.set_text(str(int(npc_spawn_timer.time_left)))
	hit_counter.set_text(str(actual_points))
	hit_counter.show()
	npc_spawn_timer.start()

func _delete_spawned_npc():
	for npc in spawned_npc:
		npc.queue_free()
	spawned_npc.clear()
	
func _on_spawn_timer_timeout():
	_delete_spawned_npc()
	var enemy_spawned: int = 0
	for spawn_point in enemy_spawn_points:
		var rand = random_number.randi_range(0, 1)
		if enemy_spawned >= max_enemies_alive and rand == 1:
			rand = 0
		match rand:
			0: #peace
				var rand_npc_idx = random_number.randi_range(0, peace_npc_scene.size()-1)
				var peace_npc = peace_npc_scene[rand_npc_idx].instantiate()
				peace_npc.global_position = spawn_point.global_position
				get_parent().add_child(peace_npc)
				spawned_npc.append(peace_npc)
			1: #enemy
				var enemy = enemy_scene.instantiate()
				enemy.global_position = spawn_point.global_position
				get_parent().add_child(enemy)
				spawned_npc.append(enemy)
				enemy_spawned += 1
	if spawned_npc.size() > 0:
		for npc in spawned_npc:
			npc.npc_hit.connect(_on_npc_hit)

func _on_npc_hit(is_enemy: bool):
	if is_enemy:
		actual_points = int(hit_counter.get_text()) + 1
	else:
		actual_points = int(hit_counter.get_text()) - 1
	hit_counter.set_text(str(actual_points))
