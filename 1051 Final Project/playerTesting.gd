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
var physicalHook = false
var airMultiplier = 1.1

var currentRopeLength
var maxRopeLength = 550

var direction = Vector2()

var from = global_position
var color = Color.CYAN
var to = Vector2.ZERO

var isOnFloor = false


func _ready():
	pass

func _physics_process(_delta):
	from = global_position
	if isHooked:
		$Body/Arm.look_at(hookPos)
	else:
		$Body/Arm.look_at(get_global_mouse_position())
	$Body/Arm.rotation_degrees -= 90
	if Input.is_action_just_pressed("left_click") and not dead:
		if $Crosshair/CollisionChecker.has_overlapping_bodies():
			physicalHook = true
		else:
			physicalHook = false
	
	hook() #checks if using hook
	
	#applies hook pull
	if Input.is_action_pressed("left_click") and not dead and isHooked:
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
		velocity.y += direction.y * hookSpeed * airMultiplier
		velocity.x = clamp(velocity.x, -350, 350) #sets max speed
		velocity.y = clamp(velocity.y, -350, 350) #sets max speed
		move_and_slide()
	
func _draw():
	if Input.is_action_pressed("left_click"):
		pass
	else:
		to = get_global_mouse_position()
	if Input.is_action_pressed("left_click") and not dead and isHooked:
		draw_line(Vector2.ZERO, to - from, color, 2.5)
		
func hook():
	if Input.is_action_just_pressed("left_click") and not dead and physicalHook:
		isHooked = true
		hookPos = get_global_mouse_position()
		if Input.is_action_pressed("left_click") and not dead:
			isHooked = true
			currentRopeLength = global_position.distance_to(hookPos)

	if Input.is_action_just_released("left_click") and isHooked:
		isHooked = false
		
func kill():
	dead = true
	$AudioStreamPlayer2D.play(1.55)
	velocity.x = 0
	velocity.y = 0
	$Body.hide()
	$Body/Arm.hide()
	$Crosshair.hide()
	$DeathParticles.position = position
	$DeathParticles.emitting = true
	await get_tree().create_timer(3.0).timeout
	$AudioStreamPlayer2D.stop()
	get_tree().reload_current_scene()
	$DeathParticles.emitting = false
	dead = false
	$Body.show()
	$Crosshair.show()
	
func victory():
	get_tree().change_scene_to_file.bind("res://victory.tscn").call_deferred()
	
func _process(_delta):
	pass
