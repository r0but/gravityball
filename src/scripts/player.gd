extends KinematicBody2D

var MOVE_SPEED = 600
var ROT_SPEED = 3.14159 * 5
var TURN_THRESHOLD = 3.14159 / 12

var down_action = "a_p1_down"
var up_action = "a_p1_up"
var right_action = "a_p1_right"
var left_action = "a_p1_left"
var controller_number = 1

func set_controller(player_num):
	down_action = str("a_p", player_num, "_down")
	up_action = str("a_p", player_num, "_up")
	right_action = str("a_p", player_num, "_right")
	left_action = str("a_p", player_num, "left")
	controller_number = player_num

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):	
	move(take_movement_input() * MOVE_SPEED * delta)
	
	deliberate_rotate(delta, take_rot_input())
	#direct_rotate(take_rot_input())

func deliberate_rotate(delta, target_vector):
	if target_vector.length() > .1:
		var target_angle = target_vector.angle()
		if get_rot() - target_angle > TURN_THRESHOLD or get_rot() - target_angle < -TURN_THRESHOLD:
			turn(delta, target_angle)

func direct_rotate(target_vector):
	if target_vector.length() > .1:
		set_rot(target_vector.angle())

func take_rot_input():
	#return get_viewport().get_mouse_pos().angle_to_point(get_pos())
	return gamepad_rot_input()

func gamepad_rot_input():
	var target_vector = Vector2(0, 0)
	target_vector.x = Input.get_joy_axis(controller_number - 1, JOY_AXIS_2)
	target_vector.y = Input.get_joy_axis(controller_number - 1, JOY_AXIS_3)
	
	return target_vector

func take_movement_input():
	#return digital_movement_input()
	return analog_movement_input()

func digital_movement_input():
	var move_vector = Vector2(0, 0)
	if Input.is_action_pressed(down_action):
		move_vector.y += 1
	if Input.is_action_pressed(up_action):
		move_vector.y -= 1
	if Input.is_action_pressed(right_action):
		move_vector.x += 1
	if Input.is_action_pressed(left_action):
		move_vector.x -= 1
	return move_vector.normalized()

func analog_movement_input():
	var move_vector = Vector2(0, 0)
	move_vector.x = Input.get_joy_axis(controller_number - 1, JOY_AXIS_0)
	move_vector.y = Input.get_joy_axis(controller_number - 1, JOY_AXIS_1)
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