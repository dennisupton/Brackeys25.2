extends Node
var oldPosition = Vector2.ZERO
var moveMagnitude = 0.5
var moveAmount = 0.1
var camera

func _ready() -> void:
	camera = $/root/main/Camera2D
	var rng = RandomNumberGenerator.new()
	moveAmount = rng.randf_range(-0.2, 0.2)
	moveMagnitude = rng.randf_range(0.35, 0.5)

func _process(delta: float) -> void:
	var position = $/root/main/Camera2D.position
	if (position != oldPosition):
		var direction = (position - oldPosition) * moveMagnitude
		self.position += direction + (Vector2.RIGHT * moveAmount)
	if (self.position.x < -2000):
		self.position.x += 2000
	if (self.position.x > 2000):
		self.position.x -= 2000
	oldPosition = position
