extends Button


func _ready():
	GlobalAudioStreamPlayer._play_level_music()
	pressed.connect(self._button_pressed)


func _button_pressed():
		get_tree().change_scene_to_file("res://world.tscn")

func _process(_delta):
	GlobalAudioStreamPlayer._play_level_music()
