extends Node2D

var player_1_score = 0
var player_2_score = 0

func _ready():
	game_reset()
	set_process(true)
	pass

func _process(delta):
	if get_node("kinematic_ball").get_pos().x < 0:
		player_2_score += 1
		get_node("player_2_score").set_text(str(player_2_score))
		ball_reset()
	if Input.is_action_pressed("ui_newgame"):
		game_reset()

func game_reset():
	player_1_score = 0
	player_2_score = 0
	get_node("player_1_score").set_text(str(player_1_score))
	get_node("player_2_score").set_text(str(player_2_score))
	ball_reset()

func ball_reset():
	get_node("kinematic_ball").set_pos(Vector2(530, 300))
	get_node("kinematic_ball").speed = 100
	get_node("kinematic_ball").move_vector = Vector2(3, 1)