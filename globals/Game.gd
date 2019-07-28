extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if Input.is_action_just_released("open_tool_menu"):
		var toolbox = get_node("/root/Level/ToolboxPopup")
		
		toolbox.visible = true
		toolbox.global_position = get_global_mouse_position()