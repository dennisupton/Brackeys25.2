extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	var sum = Vector2.ZERO
	sum += $"../Snake".position
	for i in $"../body".get_children():
		sum += i.global_position
	var average = sum/($"../body".get_child_count()+1)
	position = lerp(position,average,0.1)
