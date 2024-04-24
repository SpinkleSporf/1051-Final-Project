extends Button


func _ready():
	var button = Button.new()
	button.text = "Click me"
	button.pressed.connect(self._button_pressed)
	add_child(button)


func _button_pressed():
		print("pressed the button")
		get_tree().change_scene_to_file("res://world.tscn")

func _process(_delta):
	pass
