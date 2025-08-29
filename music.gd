extends Node2D


var lastPlay = 0

#10660 ms every loop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastPlay = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Time.get_ticks_msec()-lastPlay) > 10660:
		lastPlay = Time.get_ticks_msec()
		if $"../Snake".global_position.y < $"9".global_position.y:
			setMusicToList($"9".get_meta("music"))
		elif $"../Snake".global_position.y < $"8".global_position.y:
			setMusicToList($"8".get_meta("music"))
		elif $"../Snake".global_position.y < $"7".global_position.y:
			setMusicToList($"7".get_meta("music"))
		elif $"../Snake".global_position.y < $"6".global_position.y:
			setMusicToList($"6".get_meta("music"))
		elif $"../Snake".global_position.y < $"5".global_position.y:
			setMusicToList($"5".get_meta("music"))
		elif $"../Snake".global_position.y < $"4".global_position.y:
			setMusicToList($"4".get_meta("music"))
		elif $"../Snake".global_position.y < $"3".global_position.y:
			setMusicToList($"3".get_meta("music"))
		elif $"../Snake".global_position.y < $"2".global_position.y:
			setMusicToList($"2".get_meta("music"))
		elif $"../Snake".global_position.y < $"1".global_position.y:
			setMusicToList($"1".get_meta("music"))



func setMusicToList(list):
	$Bass.playing = list[0]
	$Chords.playing = list[1]
	$Drums.playing = list[2]
	$Melody.playing = list[3]
	$SimpleDrums.playing = list[4]
	$Violin.playing = list[5]
