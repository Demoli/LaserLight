extends Area2D

class_name BaseMirror

export var bounce_dir = -90 setget ,get_bounce_dir

func get_bounce_dir() -> float:
	return bounce_dir