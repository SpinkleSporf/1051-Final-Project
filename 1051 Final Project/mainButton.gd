extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = Button.new()
	button.text = "Click me"
	button.pressed.connect(self._button_pressed)
	add_child(button)


func _button_pressed():
		print("pressed the button")
		get_tree().change_scene_to_file("res://world.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
