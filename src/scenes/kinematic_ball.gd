extends KinematicBody2D

const MAX_SPEED = 1250
const SPEED_INCREMENT = 50
#const GRAV_CONST = 6.67408e-11
const GRAV_CONST = 1

var move_vector = Vector2(3, 1)
var grav_mass = 100
var speed = 100

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var grav_vector = get_gravity_vector(get_node("../player_1").get_pos(), get_node("../player_1").grav_mass)
	var move_vector_tick = move_vector.normalized() * speed
	move_vector_tick += grav_vector
	print(grav_vector)
	var collision_vector = move(move_vector_tick * delta)
	
	if is_colliding():
		move_vector = get_collision_normal().reflect(collision_vector)

func get_gravity_vector(player_vector, player_mass):
	var force = -GRAV_CONST * ( (player_mass * grav_mass) / get_global_pos().distance_squared_to(player_vector) ) * (get_global_pos() - player_vector).normalized()
	return force