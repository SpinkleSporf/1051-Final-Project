extends CharacterBody2D

var maxRight = 1350.0
var minLeft = 766.0
var speed = 300.0

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = -162
	position.x = 770
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
