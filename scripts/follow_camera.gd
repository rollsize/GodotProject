extends Camera2D

@onready var tile_map: TileMap = $"../../TileMap"

# Called when the node enters the scene tree for the first time.
func _ready():
	var map_rect = tile_map.get_used_rect()
	var tile_size = tile_map.cell_quadrant_size
	var world_size = map_rect.size * tile_size
	limit_right = world_size.x
	limit_bottom = world_size.y
