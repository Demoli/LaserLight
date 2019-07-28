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
		var beam = active_beams[index]
		if beam and beam.is_colliding():
			
			active_beams.remove(index)
			_draw_beam(beam, beam.get_collision_point())
			
			var collider = beam.get_collider()
			
			if collider is BaseMirror:
				bounce_beam(collider, beam.get_collision_point(), beam)
			if collider is BaseTarget and collider.color == color:
				print('beam reached targeet ' + collider.name)
			if collider is LevelTilemap or collider is BaseObstacle:
				print('beam killed by ' + collider.name)
				

func bounce_beam(mirror : BaseMirror, collision_point : Vector2, beam : RayCast2D):
	var collision_direction = to_global(beam.position).direction_to(collision_point)
	var cast_direction = collision_direction.rotated(deg2rad(mirror.bounce_dir))
	
	if mirror.global_position.x < global_position.x:
		cast_direction *= -1

	var cast = RayCast2D.new()
	cast.add_to_group("beam_casts")
	cast.cast_to = Vector2(cast_length, cast_length) * cast_direction
	cast.collide_with_areas = true
	cast.enabled = true
	cast.global_position = collision_point - global_position
	cast.add_exception(mirror)

	active_beams.append(cast)

	add_child(cast)

func _draw_beam(beam : RayCast2D, target):
	var line = Line2D.new()
	line.add_to_group("beam_lines")
	line.add_point(beam.position)
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