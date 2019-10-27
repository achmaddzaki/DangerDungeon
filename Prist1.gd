extends Node2D

var moving = false
var grid_position = Vector2(0,0)

func move(direction):
	if !moving:
		moving = true
		set_position(get_position() + 16 * direction)
		grid_position += direction
		$Timer.start(0.2)
		yield($Timer, "timeout")
		moving = false
	pass