extends KinematicBody2D

var MOVE_SPEED = 250
var ROT_SPEED = 6.28318
var target_angle = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var move_vector = Vector2(0, 0)
	if Input.is_action_pressed("a_p_down"):
		move_vector.y += 1
	if Input.is_action_pressed("a_p_up"):
		move_vector.y -= 1
	if Input.is_action_pressed("a_p_right"):
		move_vector.x += 1
	if Input.is_action_pressed("a_p_left"):
		move_vector.x -= 1
	
	move(move_vector.normalized() * MOVE_SPEED * delta)
	
	target_angle = get_viewport().get_mouse_pos().angle_to_point(get_pos())
	
	if not Input.is_action_pressed("dbg_hold"):
		if get_rot() - target_angle > .05:
			set_rot(get_rot() - ROT_SPEED * delta)
		elif get_rot() - target_angle < -.05:
			set_rot(get_rot() + ROT_SPEED * delta)