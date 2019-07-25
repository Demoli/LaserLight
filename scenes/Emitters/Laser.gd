extends Node2D

var cast_length = 500

func _ready():
	pass # Replace with function body.

func _process(delta):
	if $FirstBeam.is_colliding():
		var collider = $FirstBeam.get_collider()
		if collider is BaseMirror:
			bounce_beam(collider, $FirstBeam.get_collision_point())

func bounce_beam(mirror : BaseMirror, collision_point : Vector2):
	var bounce_dir = mirror.get_bounce_dir()
	var cast = RayCast2D.new()
	cast.cast_to = Vector2(cast_length, 0)
	cast.rotation_degrees = bounce_dir
	cast.collide_with_areas = true
	cast.enabled = true
	cast.global_position = collision_point - global_position
	add_child(cast)