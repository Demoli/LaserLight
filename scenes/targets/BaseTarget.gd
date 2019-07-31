extends Area2D

class_name BaseTarget

signal target_hit

export var color = Color.yellow

var is_hit = false setget set_is_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("targets")
	modulate = color

func set_is_hit(hit):
	is_hit = hit
	Game.on_target_hit()
	emit_signal("target_hit")