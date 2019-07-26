extends Node2D

var cast_length = 500

onready var active_beams = [
	$FirstBeam
]

func _ready():
	pass # Replace with function body.

func _process(delta):
	for index in range(active_beams.size()):
		var beam = active_beams[index]
		if beam and beam.is_colliding():
			
			var collider = beam.get_collider()
			
			if collider is BaseMirror:
				active_beams.remove(index)
				_draw_beam(beam, beam.get_collision_point())
				bounce_beam(collider, beam.get_collision_point())
		else:
			pass
			

func bounce_beam(mirror : BaseMirror, collision_point : Vector2):
	var bounce_dir = mirror.get_bounce_dir()
	var cast = RayCast2D.new()
	cast.cast_to = Vector2(cast_length, 0)
	cast.rotation_degrees = bounce_dir
	cast.collide_with_areas = true
	cast.enabled = true
	cast.global_position = collision_point - global_position
	cast.add_exception(mirror)

	active_beams.append(cast)

	add_child(cast)

func _draw_beam(beam : RayCast2D, target):
	var line = Line2D.new()
	line.add_point(beam.position)
	line.add_point(to_local(target))
	line.width = 2
	line.default_color = Color.red
	add_child(line)