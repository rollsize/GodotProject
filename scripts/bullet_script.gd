extends Area2D
class_name Bullet

@export var move_speed: float = 1000
@export var shooting_range: float = 500

var direction: Vector2 = Vector2.ZERO
var passed_range: float = 0

func _physics_process(delta):
	position += direction.normalized() *  move_speed * delta
	passed_range += move_speed * delta
	if passed_range >= shooting_range:
		queue_free()

func _on_area_entered(_area):
	queue_free()

func _on_body_entered(body):
	if body is TileMap or body is TrainingEnemy or body is PeaceNPC:
		queue_free()
