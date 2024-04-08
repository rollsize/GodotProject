extends Area2D

@onready var canvas_modulate = $"../CanvasModulate"
@onready var point_light = $"../Player/PointLight2D"

var once_entered: bool = false

func _on_body_entered(body):
	if body is Player:
		if !once_entered:
			canvas_modulate.show()
			point_light.show()
			once_entered = true
		else:
			canvas_modulate.hide()
			point_light.hide()
			once_entered = false
