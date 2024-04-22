extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_point(Vector2(0,0), 0) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#if Input.is_action_just_pressed("left_click"):
		#set_point_position(1, get_global_mouse_position())
