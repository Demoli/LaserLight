extends Area2D



func _on_DeleteToolButton_area_shape_entered(area_id, area, area_shape, self_shape):
	area.queue_free()
