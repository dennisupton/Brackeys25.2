extends Label


var start = 0
var running = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func startTime():
	start = Time.get_ticks_msec()
	running = true

func stop():
	running = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running:
		text =str(round(( Time.get_ticks_msec()-start)/100.0)/10)
