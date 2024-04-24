extends CharacterBody2D

var dead = false
var speed = 200
var hookSpeed = .08
var gravity = 5
var jumpForce = -200
var maxSpeed = 50.0
var stopTime = 1.0
var hookPos = Vector2()
var isHooked = false

var currentRopeLength
var maxRopeLength = 500

var direction = Vector2()

var from = global_position
var color = Color.CYAN
var to = Vector2.ZERO

var isOnFloor = false


func _ready():
	pass

func _physics_process(_delta):
	hook() #checks if using hook
	from = global_position
	
	#applies hook pull
	if Input.is_action_pressed("left_click") and not dead:
		move_towards_hook()
		
	if isOnFloor and not isHooked: #stops sliding on floor
		velocity.x = 0
	queue_redraw()
	
	isOnFloor = is_on_floor()
	
	# grounded movement
	if Input.is_action_pressed("ui_right") and not dead: 
		velocity.x = 1*speed
	elif Input.is_action_pressed("ui_left") and not dead:
		velocity.x = -1*speed
		
	#allows jumping
	if Input.is_action_just_pressed("jump") and isOnFloor and not dead:
		velocity.y = jumpForce
	elif not dead:
		velocity.y += gravity
		
	move_and_slide()
	
func move_towards_hook() -> void:
	if currentRopeLength < maxRopeLength:
		direction = (hookPos - global_position)
		velocity.x += direction.x * hookSpeed
		velocity.y += direction.y * hookSpeed
		velocity.x = clamp(velocity.x, -350, 350) #sets max speed
		velocity.y = clamp(velocity.y, -200, 200) #sets max speed
		move_and_slide()
	
func _draw():
	if Input.is_action_pressed("left_click"):
		pass
	else:
		to = get_global_mouse_position()
	if Input.is_action_pressed("left_click") and not dead:
		draw_line(Vector2.ZERO, to - from, color, 2.5)
		
func hook():
	$Raycast.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click") and not dead:
		isHooked = true
		hookPos = get_global_mouse_position()
		if Input.is_action_pressed("left_click") and not dead:
			isHooked = true
			currentRopeLength = global_position.distance_to(hookPos)
	else:
		$Raycast.set_visible(false)

	if Input.is_action_just_released("left_click") and isHooked:
		isHooked = false
		
func kill():
	dead = true
	velocity.x = 0
	velocity.y = 0
	$playerSprite.hide()
	$Crosshair.hide()
	$DeathParticles.position = position
	$DeathParticles.emitting = true
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()
	$DeathParticles.emitting = false
	dead = false
	$playerSprite.show()
	$Crosshair.show()
	
func _process(_delta):
	pass
