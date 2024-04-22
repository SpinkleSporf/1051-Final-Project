extends CharacterBody2D

var speed = 450
var gravity = 100

var motion = Vector2()

var hookPos = Vector2()
var hooked = false
var ropeLength = 500
var currentRopeLength


# Called when the node enters the scene tree for the first time.
func _ready():
	currentRopeLength = ropeLength # Replace with function body.

func _gravity():
	motion.y += gravity
	
func move(_delta):
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
	elif Input.is_action_pressed("ui_left"):
		motion.x = speed
	else:
		motion.x = 0
		
func _physics_process(delta):
	#print(position)
	_gravity()
	hook()
	#update()
	if hooked:
		_gravity()
		swing(delta)
		motion *= 0.975 #speed of swing
		#motion = move_and_slide()
		
	move(delta)
	#motion = move_and_slide()

func _draw():
	var pos = global_position
	
	if hooked:
		draw_line(Vector2(0,0), to_local(hookPos), Color(0.35,0.7,0.9), true) #cyan
	else:
		
		var colliding = $Raycast.move_and_slide()
		var collidePoint = $Raycast.get_collision_point()
		if colliding and pos.distance_to(collidePoint) < ropeLength:
			draw_line(Vector2(0,0), to_local(collidePoint), Color(1,1,1,0.25), 0.5, true) #white
		return
		
	
func hook():
	$Raycast.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click"):
		hookPos = getHookPos()
		if hookPos:
			hooked = true
			currentRopeLength = global_position.distance_to(hookPos)
	if Input.is_action_just_released("left_click") and hooked:
		hooked = false
	
	
func getHookPos():
	for raycast in $Raycast.get_children():
		if raycast.is_colliding():
			return raycast.get_collision_point()
			
func swing(delta):
	var radius = global_position - hookPos
	if motion.length() < 0.01 or radius.length() < 10: return
	var angle = acos(radius.dot(motion) / (radius.length() * motion.length()))
	var radVel = cos(angle) * motion.length()
	motion += radius.normalized() * -radVel
	
	if global_position.distance_to(hookPos) > currentRopeLength:
		global_position = hookPos + radius.normalized() * currentRopeLength
		
	motion += (hookPos - global_position).normalized() * 15000 * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move(_delta)
	hook()
