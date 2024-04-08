extends Area2D

@onready var task_label = $"../TaskLabel"
@onready var timer_counter = $"../TimerCounter"
@onready var hit_counter = $"../HitCounter"
@onready var task_timer: Timer = $TaskTimer
@onready var npc_spawn_timer: Timer = $"../NPCHandler/NPCSpawnTimer"
@onready var spawn_handler = $"../NPCHandler"

var once_entered: bool = false

func _process(_delta):
	if !task_timer.is_stopped():
		var time_left: int = task_timer.time_left
		timer_counter.set_text(str(time_left))
	
func _on_body_entered(body):
	if body is Player:
		if !once_entered:
			task_label.show()
			timer_counter.set_text("10") 
			timer_counter.show()
			task_timer.start()
			once_entered = true
		else:
			npc_spawn_timer.stop()
			task_label.hide()
			timer_counter.hide()
			hit_counter.hide()
			task_timer.stop()
			once_entered = false
