extends Camera2D

var rand = RandomNumberGenerator.new()
var shaking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return


func _process(_delta: float) -> void:
	var sum = Vector2.ZERO
	sum += $"../Snake".position
	for i in $"../body".get_children():
		sum += i.global_position
	var average = sum/($"../body".get_child_count()+1)
	position = lerp(position,average,0.05)
	position = lerp(position, position + Vector2(rand.randf_range(-3.0,3.0),rand.randf_range(-3.0,3.0)),$Timer.time_left*10)

func shake():
	shaking = true
	$Timer.start()
