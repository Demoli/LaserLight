extends "res://scenes/Emitters/Laser.gd"

class_name Combiner

export var input_color_1 : Color = Color.red
export var input_color_2 : Color = Color.green

onready var input_colors = [
	input_color_1,
	input_color_2,
]

var colliding_lasers = []

func _ready():
	color = Color.yellow
	._ready()
	can_fire = false

func add_colliding_laser(laser):
	if not colliding_lasers.has(laser):
		colliding_lasers.append(laser)

func combine_beams():
	if colliding_lasers.size() == 2 and input_colors_valid():
		set_process(true)

func input_colors_valid() -> bool:
	var valid = true
	for laser in colliding_lasers:
		if not input_colors.has(laser.color):
			valid = false
	
	return valid