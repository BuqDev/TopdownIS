extends Node

class_name FixRotation

@onready var p : Node2D = get_parent()

func _process(delta):
	p.rotation = 0
