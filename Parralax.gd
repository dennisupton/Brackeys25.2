extends Node
var oldPosition = Vector2.ZERO
@export var moveMagnitude = 0.5

func _process(_delta: float) -> void:
	var position =  $"../Camera2D".position
	if (position != oldPosition):
		var direction = (position - oldPosition) * moveMagnitude
		self.position += direction
	oldPosition = position
