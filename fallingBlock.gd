extends StaticBody2D

var strength = 200
@export var startStrength = 190
var orFrame = 0
var orpos= Vector2(0,0)
var rand = RandomNumberGenerator.new()
var lastAlive = 0
var respawnTime = 5000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	strength = startStrength
	orpos = $Sprite2D.position
	orFrame =$Sprite2D.frame



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Sprite2D.position = lerp($Sprite2D.position, orpos + Vector2(rand.randf_range(-3.0,3.0),rand.randf_range(-3.0,3.0)),float($Sprite2D.frame-orFrame)/8)
	if strength < startStrength:
		strength += 1
	if strength >0:
		$Sprite2D.frame = orFrame + (3-strength/(startStrength/3))
	if strength <= 0 and lastAlive == 0:
		hide()
		lastAlive = Time.get_ticks_msec()
		$CollisionShape2D.disabled = true
		$collapse.play()
	elif !(lastAlive == 0):
		if Time.get_ticks_msec()-lastAlive >respawnTime:
			lastAlive = 0
			strength = startStrength
			show()
			$CollisionShape2D.disabled = false

func hit():
	strength -= 5
	if !$break.playing:
		$break.play()
