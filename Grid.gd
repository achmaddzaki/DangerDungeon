extends TileMap

var Grid = []
var Grid_possible_move = []
var dungeon_size = Vector2(12,15)
var tile_size = 16

onready var wall_left = preload("res://Wall_Left.tscn")
onready var wall_right = preload("res://Wall_Right.tscn")
onready var wall_top = preload("res://Wall_Top.tscn")
onready var wall_bottom = preload("res://Wall_Bottom.tscn")
onready var wall_bottom_left = preload("res://Wall_Bottom_Left.tscn")
onready var wall_bottom_right = preload("res://Wall_Bottom_Right.tscn")
onready var ladder = preload("res://Ladder.tscn")
onready var GridObject = preload("res://GridObject.gd")

func _ready():
	# Mapping dungeon
	for i in range(dungeon_size.x):
		Grid.append([])
		for j in range(dungeon_size.y):
			var obj = null
			if(i == 0):
				if(j == dungeon_size.y - 1):
					obj = GridObject.new(wall_bottom_left.instance(), true)
				else:
					obj = GridObject.new(wall_left.instance(), true)
			elif(i == dungeon_size.x - 1):
				if(j == dungeon_size.y - 1):
					obj = GridObject.new(wall_bottom_right.instance(), true)
				else:
					obj = GridObject.new(wall_right.instance(), true)
			elif(j == 0):
				obj = GridObject.new(wall_top.instance(), true)
			elif(j == dungeon_size.y - 1):
				obj = GridObject.new(wall_bottom.instance(), true)
			Grid[i].append(obj)
			
			if(Grid[i][j] != null):
				Grid[i][j].instance.set_position(Vector2(i*tile_size, j*tile_size))
				add_child(Grid[i][j].instance)
	
	# Place ladder in random location
	var ladder_pos = get_random_pos()
	add_obj_to_grid(ladder_pos, ladder.instance(), false)
	var wall_pos = get_random_pos()
	add_obj_to_grid(wall_pos, wall_top.instance(), true)
	pass

func add_obj_to_grid(pos, instance, is_collide):
	Grid[pos.x][pos.y] = GridObject.new(instance, is_collide)
	Grid[pos.x][pos.y].instance.set_position(Vector2(pos.x*tile_size, pos.y*tile_size))
	add_child(Grid[pos.x][pos.y].instance)
	pass

func get_random_pos():
	var x = int(rand_range(1, dungeon_size.x - 1))
	var y = int(rand_range(1, dungeon_size.y - 1))
	if(Grid[x][y] == null):
		return Vector2(x, y)
	else:
		return get_random_pos()

func is_move_possible(pos, direction):
	var grid_pos = pos + direction
	if(grid_pos.x > 0 && grid_pos.x < dungeon_size.x - 1):
		if(grid_pos.y > 0 && grid_pos.y < dungeon_size.y - 1):
			if(Grid[grid_pos.x][grid_pos.y] == null || !Grid[grid_pos.x][grid_pos.y].is_collide):
				return true
	return false

func show_possible_move(pos, step):
	Grid_possible_move = []
	for i in range(dungeon_size.x):
		Grid_possible_move.append([])
		for j in range(dungeon_size.y):
			Grid_possible_move[i].append(null)
	
	Grid_possible_move[pos.x][pos.y] = false
	
	check_possible_move(pos, step)
	for i in range(Grid_possible_move.size()):
		print(Grid_possible_move[i])
	pass

func check_possible_move(pos, step):
	# Check left
	var left = pos + Vector2.LEFT
	check_possible_move_direction(left, step)
	
	# Check right
	var right = pos + Vector2.RIGHT
	check_possible_move_direction(right, step)
	
	# Check up
	var up = pos + Vector2.UP
	check_possible_move_direction(up, step)
	
	# Check down
	var down = pos + Vector2.DOWN
	check_possible_move_direction(down, step)
	pass

func check_possible_move_direction(direction, step):
	if(direction.y > 0 && direction.y < dungeon_size.y - 1):
		if Grid_possible_move[direction.x][direction.y]:
			if(step > 1):
				check_possible_move(direction, step - 1)
		elif (Grid[direction.x][direction.y] == null || !Grid[direction.x][direction.y].is_collide) && Grid_possible_move[direction.x][direction.y] == null:
			Grid_possible_move[direction.x][direction.y] = true
			if(step > 1):
				check_possible_move(direction, step - 1)
		else:
			Grid_possible_move[direction.x][direction.y] = false
	pass
