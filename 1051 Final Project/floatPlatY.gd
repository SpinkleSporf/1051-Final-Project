extends CharacterBody2D

var maxHeight = 10.0
var minHeight = -270.0
var speed = 150.0

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 10
	position.y = -265
	velocity.y = speed

func _physics_process(_delta):
	if position.y <= minHeight:
		velocity.y = speed
	if position.y >= maxHeight:
		velocity.y = -speed 
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
