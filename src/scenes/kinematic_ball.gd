extends KinematicBody2D

const MAX_SPEED = 1250
const SPEED_INCREMENT = 50
const GRAV_CONST = 6.67408e-11

var move_vector = Vector2(3, 1)
var mass = 1
var speed = 100

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var collision_vector = move(move_vector.normalized() * speed * delta)
	
	if is_colliding():
		move_vector = get_collision_normal().reflect(collision_vector)
		if speed < MAX_SPEED:
			if speed + SPEED_INCREMENT < MAX_SPEED:
				speed += SPEED_INCREMENT
			else:
				speed = MAX_SPEED

func get_gravity_vector(player_vector, player_mass):
	return GRAV_CONST * ( (player_mass * mass) / (