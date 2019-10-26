extends Node2D

var direction = Vector2.DOWN

func _process(delta):
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		set_process(false)
		if Input.is_action_pressed("ui_up"):
			direction = Vector2.UP
		elif Input.is_action_pressed("ui_down"):
			direction = Vector2.DOWN
		elif Input.is_action_pressed("ui_right"):
			direction = Vector2.RIGHT
		elif Input.is_action_pressed("ui_left"):
			direction = Vector2.LEFT
		
		# Check if move possible
		
		
		# Move char
		if($Grid.is_move_possible($Grid/Player.grid_position, direction)):
			$Grid/Player.move(direction)
		set_process(true)
	pass
