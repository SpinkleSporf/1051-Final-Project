extends Sprite2D


func _ready():
	pass 
	
func _physics_process(_delta):
	if Input.is_action_pressed("left_click"):
		pass
	else:
		position = get_global_mouse_position()
	
