extends CharacterBody2D

var speed = 200
var hookSpeed = .08
var gravity = 5
var jumpForce = -200
var maxSpeed = 50.0
var stopTime = 1.0
var hookPos = Vector2()
var isHooked = false

var currentRopeLength

var direction = Vector2()

var from = global_position
var color = Color.CYAN
var to = Vector2.ZERO

var isOnFloor = false

var hookVelocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	hook() #checks if using hook
	from = global_position
	
	#applies hook pull
	if Input.is_action_pressed("left_click"):
		move_towards_hook()
		
	if isOnFloor and not isHooked: #stops sliding on floor
		velocity.x = 0
	queue_redraw()
	
	isOnFloor = is_on_floor()
	
	# grounded movement
	if Input.is_action_pressed("ui_right"): 
		velocity.x = 1*speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1*speed
		
	#allows jumping
	if Input.is_action_just_pressed("jump") and isOnFloor:
		velocity.y = jumpForce
	else:
		velocity.y += gravity
		
	move_and_slide()
			
func getHookPos():
	if $Raycast.is_colliding():
		return $Raycast.get_collision_point()
			
func move_towards_hook() -> void:
	direction = (hookPos - global_position)
	velocity.x += direction.x * hookSpeed
	velocity.y += direction.y * hookSpeed
	velocity.x = clamp(velocity.x, -300, 300) #sets max speed
	velocity.y = clamp(velocity.y, -200, 200) #sets max speed
	#print(velocity)
	move_and_slide()
	
func _draw():
	if Input.is_action_pressed("left_click") :
		pass
	else:
		to = get_global_mouse_position()
	if Input.is_action_pressed("left_click") :
		draw_line(Vector2.ZERO, to - from, color, 2.5)
		
func hook():
	$Raycast.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click") :
		isHooked = true
		hookPos = get_global_mouse_position()
		
		if hookPos:
			isHooked = true
			currentRopeLength = global_position.distance_to(hookPos)
	else:
		$Raycast.set_visible(false)

	if Input.is_action_just_released("left_click") and isHooked:
		isHooked = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
