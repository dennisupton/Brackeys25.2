extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		visible = !visible
		if visible:
			$"../..".process_mode = Node.PROCESS_MODE_DISABLED
		else:
			$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE
