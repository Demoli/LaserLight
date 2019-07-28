extends Area2D

class_name BaseMirror

var bounce_dir = 0 setget ,get_bounce_dir
var collision_shapes = []

func _ready():
	for child in get_children():
		if child is CollisionShape2D:
			collision_shapes.append(child)

func get_bounce_dir() -> float:
	return bounce_dir
	
func get_collision_shape(id: int) -> CollisionShape2D:
	return collision_shapes[id]

func get_entry_bounce_dir(shape : CollisionShape2D):
	if shape.name == 'FacingEntry':
		return bounce_dir
	if shape.name == 'InvertedEntry':
		return bounce_dir * -1