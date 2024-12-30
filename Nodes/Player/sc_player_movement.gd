extends Node
class_name PlayerMovement

@export var rb : CharacterBody2D

@export var MOVE_SPEED      : float = 300
@export var MOVE_ACCEL      : float = 5_000
@export var SLOW_MOVE_SPEED : float = 30
@export var SLOW_DOWN_TIME  : float = .2

var input_vector : Vector2
var target_speed : float
var velocity     : Vector2

func _ready():
	if not rb: rb = get_parent()

func _physics_process(delta):
	_speed_up  (delta)
	_slow_down (delta)
	
	rb.velocity = velocity
	rb.move_and_slide()
	
	var PUSH_FORCE = 5.0
	var MIN_PUSH_FORCE = 2.0
	
	for i in rb.get_slide_collision_count():
		var c = rb.get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE * velocity.length() / MOVE_ACCEL)
			push_force += MIN_PUSH_FORCE
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			velocity += c.get_normal() * 2

func _speed_up(delta):
	input_vector   = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up"  , "move_down" )
	
	target_speed = MOVE_SPEED
	if Input.is_action_pressed("slow_walk") : target_speed = SLOW_MOVE_SPEED
	
	velocity += input_vector * delta * MOVE_ACCEL
	
	if velocity.length() > MOVE_SPEED:
		velocity = velocity.normalized() * target_speed
	

func _slow_down(delta):
	if input_vector != Vector2.ZERO: return
	
	velocity = lerp(velocity, Vector2.ZERO, SLOW_DOWN_TIME)
	
