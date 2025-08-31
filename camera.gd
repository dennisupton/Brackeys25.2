extends Camera2D

var rand = RandomNumberGenerator.new()
var shaking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	AudioServer.set_bus_volume_db(1, -90)
	$Logo.show()

func _process(_delta: float) -> void:
	if  $Logo.frame == 14 and $Logo.visible:
		$Logo.hide()
		get_tree().paused = false
	elif $Logo.visible:
		AudioServer.set_bus_volume_db(1, -90)
	else:
		AudioServer.set_bus_volume_db(1, -10)
	var sum = Vector2.ZERO
	sum += $"../Snake".position
	for i in $"../body".get_children():
		sum += i.global_position
	var average = sum/($"../body".get_child_count()+1)
	position = lerp(position,average,0.05)
	position = lerp(position, position + Vector2(rand.randf_range(-4.0,4.0),rand.randf_range(-4.0,4.0)),$Timer.time_left*10)

func shake():
	shaking = true
	$Timer.start()
