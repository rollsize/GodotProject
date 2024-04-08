extends Control
class_name MainMenu

@onready var choose_arcade_lvl_menu = preload("res://scenes/UI/ChooseArcadeMenu.tscn") as PackedScene
#@onready var parametrs_menu = preload("res://scenes/UI/ParametrsMenu.tscn") as PackedScene
@onready var story_level = preload("res://scenes/levels/TrainingLevel.tscn") as PackedScene
#@onready var arcade_level = preload("res://scenes/levels/ArcadeLevel.tscn") as PackedScene
@onready var margin_container = $MarginContainer
@onready var temp_message_menu = $TempMessageMenu
@onready var settings_menu = $SettingsMenu as SettingsMenu

func _ready():
	#temp_message_menu.hide()
	var default_cursor = _load_cursor(32, 32)
	Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2(16, 16))
	settings_menu.exit_settings_menu.connect(_on_exit_parametrs_pressed)

func _on_story_mode_pressed():
	get_tree().change_scene_to_packed(story_level)

func _on_arcade_pressed():
	pass
	#get_tree().change_scene_to_packed(arcade_level)
	#get_tree().change_scene_to_packed(choose_arcade_lvl_menu)

func _on_parametrs_pressed():
	#get_tree().change_scene_to_packed(settings_menu)
	margin_container.hide()
	settings_menu.set_process(true)
	settings_menu.show()

func _on_exit_parametrs_pressed():
	settings_menu.hide()
	margin_container.show()

func _on_exit_pressed():
	get_tree().quit()

func _load_cursor(resize_width: int, resize_height: int) -> ImageTexture:
	var idle_cursor = preload("res://sprites/weapons/IdleCrosshair.png")
	idle_cursor.resize(resize_width, resize_height)
	return ImageTexture.create_from_image(idle_cursor)
