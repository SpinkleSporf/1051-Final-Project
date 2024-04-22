extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#const SPEED = 200 # Set a higher speed to follow the mouse faster

func _physics_process(_delta):
	if Input.is_action_pressed("left_click"):
		pass
	else:
		position = get_global_mouse_position()
	
