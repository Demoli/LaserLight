tool
extends Node2D

class_name Draggable

signal drag_clicked
signal drag_start
signal drag_end

enum DRAG_STATE {DRAGGING, CLICKED, NOT_DRAGGING}

export (NodePath) var drag_sprite
export (DRAG_STATE) var status = DRAG_STATE.NOT_DRAGGING

var tsize=Vector2()
var mpos=Vector2()
var sprite : Sprite = null

func _ready():
	sprite = get_node(drag_sprite) 
	tsize=sprite.get_texture().get_size()
	set_process_input(true)
	set_process(true)


func _process(delta):
	if status == DRAG_STATE.DRAGGING:
		get_parent().set_global_position(mpos.snapped(Vector2(35,35)))

func _input(ev):
	
	if not ev is InputEventMouse and not ev is InputEventMouseButton:
		return
	
	if ev is InputEventMouse and ev.is_pressed() and ev.button_mask == BUTTON_LEFT  and status != DRAG_STATE.DRAGGING:
		var evpos=ev.global_position
		var gpos=get_global_position()
		var spriterect
		
		if sprite.is_centered():
		    spriterect=Rect2(gpos.x-tsize.x/2, gpos.y-tsize.y/2, tsize.x, tsize.y)
		else:
			spriterect=Rect2(gpos.x, gpos.y, tsize.x, tsize.y)
		
		if spriterect.has_point(evpos):
			status = DRAG_STATE.CLICKED
			emit_signal("drag_clicked")

	if status==DRAG_STATE.CLICKED:
		status = DRAG_STATE.DRAGGING
		emit_signal("drag_start")

	if ev is InputEventMouseButton and not ev.is_pressed():
		status = DRAG_STATE.NOT_DRAGGING
		emit_signal("drag_end")
	
	mpos=ev.global_position