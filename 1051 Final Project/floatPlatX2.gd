extends CharacterBody2D

var maxRight = 2365.0
var minLeft = 2220.0
var speed = 75.0

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = -220
	position.x = 2225
	velocity.x = speed

func _physics_process(_delta):
	if position.x <= minLeft:
		velocity.x = speed
	if position.x >= maxRight:
		velocity.x = -speed
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
