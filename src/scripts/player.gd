extends KinematicBody2D

var MOVE_SPEED = 250
var ROT_SPEED = 3.14159 * 2.75
var TURN_STEP_SIZE = 3.14159 / 30

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):	
	move(take_movement_input() * MOVE_SPEED * delta)
	
	var target_vector = take_rot_input()
	
	if target_vector.length() > .1:
		var target_angle = target_vector.angle()
		if get_rot() - target_angle > TURN_STEP_SIZE or get_rot() - target_angle < -TURN_STEP_SIZE:
			turn(delta, target_angle)

func take_rot_input():
	#return get_viewport().get_mouse_pos().angle_to_point(get_pos())
	return gamepad_rot_input()

func gamepad_rot_input():
	var target_vector = Vector2(0, 0)
	target_vector.x = Input.get_joy_axis(0, JOY_AXIS_2)
	target_vector.y = Input.get_joy_axis(0, JOY_AXIS_3)
	
	return target_vector

func take_movement_input():
	#return digital_movement_input()
	return analog_movement_input()

func digital_movement_input():
	var move_vector = Vector2(0, 0)
	if Input.is_action_pressed("a_p_down"):
		move_vector.y += 1
	if Input.is_action_pressed("a_p_up"):
		move_vector.y -= 1
	if Input.is_action_pressed("a_p_right"):
		move_vector.x += 1
	if Input.is_action_pressed("a_p_left"):
		move_vector.x -= 1
	return move_vector.normalized()

func analog_movement_input():
	var move_vector = Vector2(0, 0)
	move_vector.x = Input.get_joy_axis(0, JOY_AXIS_0)
	move_vector.y = Input.get_joy_axis(0, JOY_AXIS_1)
	return move_vector

func turn(delta, target_angle):
	if get_rot() >= 0:
		if target_angle < get_rot() - 3.14159 or target_angle > get_rot(): 
			set_rot(get_rot() + ROT_SPEED * delta)
		else:
			set_rot(get_rot() - ROT_SPEED * delta)
	elif get_rot() < 0:
		if target_angle < get_rot() + 3.14159 and target_angle > get_rot():
			set_rot(get_rot() + ROT_SPEED * delta)
		else:
			set_rot(get_rot() - ROT_SPEED * delta)