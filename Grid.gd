extends TileMap

var Grid = []
var dungeon_size = Vector2(12,15)
var tile_size = 16

onready var wall_left = preload("res://Wall_Left.tscn")
onready var wall_right = preload("res://Wall_Right.tscn")
onready var wall_top = preload("res://Wall_Top.tscn")
onready var wall_bottom = preload("res://Wall_Bottom.tscn")
onready var wall_bottom_left = preload("res://Wall_Bottom_Left.tscn")
onready var wall_bottom_right = preload("res://Wall_Bottom_Right.tscn")

func _ready():
	# Mapping dungeon
	for i in range(dungeon_size.x):
		Grid.append([])
		for j in range(dungeon_size.y):
			var obj = null
			if(i == 0):
				if(j == dungeon_size.y - 1):
					obj = wall_bottom_left.instance()
				else:
					obj = wall_left.instance()
			elif(i == dungeon_size.x - 1):
				if(j == dungeon_size.y - 1):
					obj = wall_bottom_right.instance()
				else:
					obj = wall_right.instance()
			elif(j == 0):
				obj = wall_top.instance()
			elif(j == dungeon_size.y - 1):
				obj = wall_bottom.instance()
			Grid[i].append(obj)
			
			if(Grid[i][j] != null):
				Grid[i][j].set_position(Vector2(i*tile_size, j*tile_size))
				add_child(Grid[i][j])
	print(is_move_possible(Vector2(1,1),Vector2.LEFT), "left")
	print(is_move_possible(Vector2(1,1),Vector2.RIGHT), "right")
	print(is_move_possible(Vector2(1,1),Vector2.UP), "up")
	print(is_move_possible(Vector2(1,1),Vector2.DOWN), "down")
	pass

func is_move_possible(pos, direction):
	var grid_pos = pos + direction
	if(grid_pos.x > 0 && grid_pos.x < dungeon_size.x - 1):
		if(grid_pos.y > 0 && grid_pos.y < dungeon_size.y - 1):
			if(Grid[grid_pos.x][grid_pos.y] == null):
				return true
	return false