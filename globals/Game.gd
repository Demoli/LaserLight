extends Node2D

var targets_hit = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
		connect("target_hit", self, "on_target_hit")

func _input(event):
	if Input.is_action_just_released("open_tool_menu"):
		var toolbox = get_node("/root/Level/ToolboxPopup")
		
		toolbox.visible = true
		toolbox.global_position = get_global_mouse_position()
		
func on_target_hit():
	targets_hit += 1
	
	if targets_hit == get_tree().get_nodes_in_group("targets").size():
		level_complete()

func level_complete():
	get_node("/root/Application/LevelComplete").popup_centered()