var instance
var is_collide

func _init(_instance, _is_collide):
    self.instance = _instance
    self.is_collide = _is_collide

func set_val(_instance, _is_collide):
    self.instance = _instance
    self.is_collide = _is_collide

func get_instance():
    return self.instance
	
func get_is_collide():
    return self.is_collide