extends Node
var oldPosition = Vector2.ZERO
var moveMagnitude = 0.5

func _process(delta: float) -> void:
	var position =  $"../Camera2D".position
	if (position != oldPosition):
		var direction = (position - oldPosition) * moveMagnitude
		self.position += direction
	oldPosition = position
