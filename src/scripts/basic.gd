extends Node2D

func _ready():
	set_process(true)
	pass

func _process(delta):
	if Input.is_action_pressed("ui_newgame"):
		get_node("rigid_ball").set_pos(Vector2(530, 300))
		get_node("rigid_ball").set_linear_velocity(Vector2(0, 0))
		get_node("rigid_ball").set_angular_velocity(0)