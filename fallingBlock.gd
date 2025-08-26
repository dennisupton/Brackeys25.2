extends StaticBody2D

var strength = 200
@export var startStrength = 300
var orFrame = 0
var orpos= Vector2(0,0)
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	strength = startStrength
	orpos = position
	orFrame =$Sprite2D.frame



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(position, orpos + Vector2(rand.randf_range(-3.0,3.0),rand.randf_range(-3.0,3.0)),float($Sprite2D.frame-orFrame)/8)
	if strength >0:
		$Sprite2D.frame = orFrame + (3-strength/(startStrength/3))
	if strength <= 0:
		queue_free()


func hit():
	strength -= 5
