extends AudioStreamPlayer

const levelMusic = preload("res://sounds/BeepBox-Song.wav")

func _play_music(music: AudioStream):
	if stream ==  music:
		if not playing:
			play()
		return
	if not playing:
		play()
	stream = music
	play()
	

func _play_level_music():
	_play_music(levelMusic)
