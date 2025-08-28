extends Node
var oldPosition = Vector2.ZERO
var moveMagnitude = 20

func _process(delta: float) -> void:
	var position =  $"../Camera2D".position
	if (position != oldPosition):
		var direction = (position - oldPosition) * moveMagnitude * get_process_delta_time()
		self.position += direction
	oldPosition = position
