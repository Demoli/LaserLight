extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var pos1 = $Mirror1.position
	var pos2 = $Mirror2.position

	var pos2_to_pos1 = pos1 - pos2
	var pos1_to_pos2 = pos2 - pos1
	
	print(pos1_to_pos2.normalized().dot(pos2_to_pos1.normalized()))