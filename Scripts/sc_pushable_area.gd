extends Area2D
class_name PushableArea

@export var rb : RigidBody2D
static var PUSH_FORCE : float = 1000

func _ready():
	pass
	#if not rb : rb = get_parent()
	#body_entered.connect(_bump)
	

func _bump(body : Node2D):
	force_update_transform()
	#if not     (body is RigidBody2D) \
	   #and not (body is CharacterBody2D) : return
	#
	#var d : Vector2 = body.position - position
	#var f : Vector2 = d.normalized()
	#rb.linear_velocity = f * 100
	#
	#print(f)
	
