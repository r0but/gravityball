extends KinematicBody2D

const MAX_SPEED = 1250
const SPEED_INCREMENT = 50
#const GRAV_CONST = 6.67408e-11
const GRAV_CONST = 1

var move_vector = Vector2(3, 1)
var mass = 1
var speed = 100

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var grav_vector = get_gravity_vector(get_node("../player_1").get_pos(), get_node("../player_1").grav_mass)
	print("grav_vector: ", grav_vector)
	var collision_vector = move(move_vector.normalized() * speed * delta)
	
	if is_colliding():
		move_vector = get_collision_normal().reflect(collision_vector)
		if speed < MAX_SPEED:
			if speed + SPEED_INCREMENT < MAX_SPEED:
				speed += SPEED_INCREMENT
			else:
				speed = MAX_SPEED

func get_gravity_vector(player_vector, player_mass):
	var abs_diff = Vector2()
	abs_diff.x = abs(get_global_pos().x - player_vector.x)
	abs_diff.y = abs(get_global_pos().y - player_vector.y)
	
	var unit_vector_diff = (get_global_pos() - player_vector) / abs_diff
	unit_vector_diff = unit_vector_diff.normalized()
	var grav_vector = GRAV_CONST * ( (player_mass * mass) * (1 / abs_diff) ) * unit_vector_diff
	print("grav vector: ", grav_vector)
	return grav_vector