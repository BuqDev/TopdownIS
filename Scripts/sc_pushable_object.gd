extends Node
class_name PushableObject

@export var rb       : RigidBody2D
@export var FRICTION : float = .5

var being_pushed := false

func _ready():
	if not rb : rb = get_parent()
func _physics_process(delta):
	rb.apply_central_impulse(-rb.linear_velocity * FRICTION * delta)
