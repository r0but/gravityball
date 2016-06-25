extends Label

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_text(str(get_node("../player").get_rot()) + "\n" + str(get_node("../player").target_angle))