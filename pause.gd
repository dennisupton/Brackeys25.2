extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		visible = !visible
		if visible:
			$"../..".process_mode = Node.PROCESS_MODE_DISABLED
		else:
			$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE


func _on_back_pressed() -> void:
	visible = !visible
	if visible:
		$"../..".process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE





func _on_restart_pressed() -> void:
	$"../../Snake".position = Vector2(300,260)
	$"../../body".position = Vector2(635,-120)
	visible = !visible
	if visible:
		$"../..".process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE
