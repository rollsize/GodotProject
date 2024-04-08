extends CharacterBody2D
#class_name Player

@export var move_speed: float = 600
@export var toward_delta: float = 50

@onready var anim_player: AnimationPlayer = $AnimationPlayer 
#TODO: Анимации

func _ready():
	anim_player.play("Idle")
	#func _ready():
	#screen_size = get_viewport_rect().size

func _process(_delta):
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
	if Input.is_action_just_pressed("shoot"): #TODO: Зажим
		_shoot()

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() > 0:
		set_velocity(direction * move_speed)
	else:
		set_velocity(Vector2(move_toward(velocity.x, 0, toward_delta), move_toward(velocity.y, 0, toward_delta)))				
	if get_velocity().length() > 0 && anim_player.is_playing():
		anim_player.stop()
	elif get_velocity().length() == 0 && !anim_player.is_playing():
		anim_player.play("Idle")
	move_and_slide()

func _shoot():
	print("Shot'em up")
