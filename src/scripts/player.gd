extends KinematicBody2D

var MOVE_SPEED = 600

var grav_mass = 100000
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