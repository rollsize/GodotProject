extends RigidBody2D
class_name ImpactGrenade

signal grenade_exploded(damage_to_deal: float)

@export var damage:float = 50
@onready var timer = $Timer

var direction: Vector2 = Vector2.ZERO
var passed_range: float = 0

func _physics_process(_delta):
	timer.start()
	if timer.is_stopped():
		print("timer.time_left")
	#position += direction.normalized() *  move_speed * delta
	#passed_range += move_speed * delta
	#if passed_range >= shooting_range:
		#queue_free()

func _on_area_entered(_area):
	queue_free()

func _on_body_entered(body):
	if body is Enemy or body is TileMap or body is NPC:
		queue_free()


func _on_timer_timeout():
	print("timer.time_left")
	grenade_exploded.emit(damage)
