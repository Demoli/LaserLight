extends Node2D

export var cast_length = 1000
export var color = Color.red

onready var active_beams = [
	$FirstBeam
]

func _ready():
	set_process(false)
	modulate = color
	pass # Replace with function body.

func _process(delta):
	for index in range(active_beams.size()):
		if index > active_beams.size() -1 :
			break
			
		var beam = active_beams[index]
		if beam and beam.is_colliding():
			
			active_beams.remove(index)
			var collider = beam.get_collider()
			
			_draw_beam(beam.position, beam.get_collision_point())
	
			if collider is BaseMirror:
				# complete the beam as collider is not at position 0
				_draw_beam(to_local(collider.position), beam.get_collision_point())
				# bounce beam to next target
				bounce_beam(collider, beam.get_collision_point(), beam)
			if collider is Splitter:
				split_beam(collider, beam.get_collision_point(), beam)
			if collider is BaseTarget and collider.color == color:
				# complete the beam as collider is not at position 0
				_draw_beam(to_local(collider.position), beam.get_collision_point())
				_draw_beam(to_local(collider.position), beam.get_collision_point())
				print('beam reached targeet ' + collider.name)
			if collider is LevelTilemap or collider is BaseObstacle:
				print('beam killed by ' + collider.name)
				

func bounce_beam(mirror : BaseMirror, collision_point : Vector2, beam : RayCast2D):
	var collision_direction = to_global(beam.position).direction_to(collision_point)
	var shape = mirror.get_collision_shape(beam.get_collider_shape())
	var cast_direction = collision_direction.rotated(deg2rad(mirror.get_entry_bounce_dir(shape)))
	var beamdir = mirror.position.direction_to(beam.position)
	
	_create_beam(mirror.global_position - global_position, cast_direction, mirror)

func split_beam(mirror : Splitter, collision_point : Vector2, beam : RayCast2D):
	
	var angles = [45,-45]
	var collision_direction = to_global(beam.position).direction_to(collision_point)
		
	for angle in angles:
		var cast_direction = collision_direction.rotated(deg2rad(angle))
		_create_beam(collision_point - global_position, cast_direction, mirror)

func _create_beam(initial_position : Vector2, cast_direction : Vector2, exception):
	var cast = RayCast2D.new()
	cast.add_to_group("beam_casts")
	cast.cast_to = Vector2(cast_length, cast_length) * cast_direction
	cast.collide_with_areas = true
	cast.enabled = true
	cast.global_position = initial_position
	cast.add_exception(exception)

	active_beams.append(cast)

	add_child(cast)	

func _draw_beam(from : Vector2, target : Vector2):
	var line = Line2D.new()
	line.add_to_group("beam_lines")
	line.add_point(from)
	line.add_point(to_local(target))
	line.width = 2
	line.default_color = color
	add_child(line)
	
func _input(event):
	if Input.is_action_pressed("laser_fire"):
		set_process(true)
	if Input.is_action_pressed("reset_laser"):
		reset()
		
func reset():
	var objects = get_tree().get_nodes_in_group("beam_casts")
	objects += get_tree().get_nodes_in_group("beam_lines")
	
	for object in objects:
		object.queue_free()
		
	active_beams = [
		$FirstBeam
	]
	
	set_process(false)