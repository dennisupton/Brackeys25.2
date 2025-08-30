extends Node2D


var lastPlay = 0
var currentList

#10660 ms every loop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentList = $"1".get_meta("music")
	lastPlay = Time.get_ticks_msec()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	CheckMusic()
	
			
func CheckMusic():
	if (Time.get_ticks_msec() - lastPlay) > (21333.333333):
		lastPlay = Time.get_ticks_msec()
		var snakePos = $"../Snake".global_position
		print(str(snakePos.y) + " " + str($"9".global_position.y))
		if snakePos.y < $"9".global_position.y:
			currentList = $"9".get_meta("music")
			return
		elif snakePos.y < $"8".global_position.y:
			currentList = $"8".get_meta("music")
			return
		elif snakePos.y < $"7".global_position.y:
			currentList = $"7".get_meta("music")
			return
		elif snakePos.y < $"6".global_position.y:
			currentList = $"6".get_meta("music")
			return
		elif snakePos.y < $"5".global_position.y:
			currentList = $"5".get_meta("music")
			return
		elif snakePos.y < $"4".global_position.y:
			currentList = $"4".get_meta("music")
			return
		elif snakePos.y < $"3".global_position.y:
			currentList = $"3".get_meta("music")
			return
		elif snakePos.y < $"2".global_position.y:
			currentList = $"2".get_meta("music")
			return
		elif snakePos.y < $"1".global_position.y:
			currentList = $"1".get_meta("music")
			return
	setMusicToList(currentList)



func setMusicToList(list):
	if (list[0] && !$SimpleDrums.playing):
		$SimpleDrums.playing = true
	$SimpleDrums.stream_paused = !list[0]
	if (list[1] && !$Drums.playing):
		$Drums.playing = true
	$Drums.stream_paused = !list[1]
	if (list[2] && !$Bass.playing):
		$Bass.playing = true
	$Bass.stream_paused = !list[2]
	if (list[3] && !$CounterMelody.playing):
		$CounterMelody.playing = true
	$CounterMelody.stream_paused = !list[3] 
	if (list[4] && !$Chords.playing):
		$Chords.playing = true
	$Chords.stream_paused = !list[4]
	if (list[5] && !$Melody.playing):
		$Melody.playing = true
	$Melody.stream_paused = !list[5]
	if (list[6] && !$Violin.playing):
		$Violin.playing = true
	$Violin.stream_paused = !list[6]
