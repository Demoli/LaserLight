extends TextureButton

export var spawn : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_ToolButton_pressed():
	var scene = spawn.instance()
	get_node("/root/Level").add_child(scene)
	scene.get_node("Draggable").status = Draggable.DRAG_STATE.DRAGGING
	scene.global_position = get_global_mouse_position()
