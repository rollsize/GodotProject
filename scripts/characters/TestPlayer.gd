extends CharacterBody2D
class_name Player

@onready var ray_cast_2d = $RayCast2D
@export var bullet_scene: PackedScene
@export var move_speed : float = 300
@export var toward_delta : float = 50
const tactical_cursor = preload("res://sprites/weapons/TacticalCrosshair.png")
#TODO: @onready var weapon: Weapon

enum STATES { IDLE, TACTICAL, INCUTSCENE }
var state: STATES

func _ready():
	state = STATES.IDLE
	$muzzleflash.hide()

func _process(_delta):
	#if Input.is_action_just_pressed("exit"):
	#	get_tree().quit()
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0

func _physics_process(_delta):
	_movement_handler()
	
func _movement_handler():
	if state != STATES.INCUTSCENE:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
		if direction.length() > 0:
			set_velocity(direction * move_speed)
		else:
			set_velocity(Vector2(move_toward(velocity.x, 0, toward_delta), move_toward(velocity.y, 0, toward_delta)))				
		move_and_slide()

func _input(event):
	if event.is_action_pressed("shoot"):
		_shoot() # TODO: weapon.fire()

func _shoot():
	if state != STATES.INCUTSCENE:
		var bullet = bullet_scene.instantiate()
		bullet.direction = Vector2.from_angle(global_rotation-PI/2.0)
		bullet.global_position = $BulletPosition.global_position
		get_parent().add_child(bullet)
		$ShootSound.play()
		$muzzleflash.show()
		$muzzleflash/Timer.start()
		if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method("kill"):
			ray_cast_2d.get_collider().kill()

func _change_state(new_state: STATES):
	state = new_state
	if state == STATES.TACTICAL:
		Input.set_custom_mouse_cursor(tactical_cursor)
